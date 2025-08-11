//
//  ShotListViewController.swift
//  Drrrible
//
//  Created by 도미닉 on 8/10/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import UIKit
import ReactorKit
import RxDataSources

class ShotListViewController: BaseViewController, View {
    private let analytics: DrrribleAnalytics
    private let shotTileCellDependency: ShotTileCell.Dependency
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
    }
    private lazy var collectionView = UICollectionView(frame: .init(), collectionViewLayout: flowLayout).then {
        $0.register(ShotTileCell.self, forCellWithReuseIdentifier: "ShotTileCell")
    }
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<ShotListViewSection>.init(configureCell: { dataSource, collectionView, indexPath, sectionItem in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShotTileCell", for: indexPath) as? ShotTileCell else { return UICollectionViewCell() }
        switch sectionItem {
        case .shotTile(let reactor):
            cell.dependency = self.shotTileCellDependency
            cell.reactor = reactor
        }
        return cell
    })
    
    init(
        reactor: ShotListViewReactor,
        analytics: DrrribleAnalytics,
        shotTileCellDependency: ShotTileCell.Dependency
    ) {
        self.analytics = analytics
        self.shotTileCellDependency = shotTileCellDependency
        super.init()
        self.reactor = reactor
        self.title = "shots".localized
        self.tabBarItem.image = UIImage(named: "tab-shots")
        self.tabBarItem.selectedImage = UIImage(named: "tab-shots-selected")
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureUI()
    }
    
    func bind(reactor: ShotListViewReactor) {
        rx.viewDidLoad
            .map { ShotListViewReactor.Action.showShotList }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.sections }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.delegate = self
    }
}

extension ShotListViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: cellSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellItemForRow: CGFloat = 3
        let minimumSpacing: CGFloat = 10
        
        let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
        
        return CGSize(width: width, height: width)
    }
    
    // MARK: minimumSpacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
