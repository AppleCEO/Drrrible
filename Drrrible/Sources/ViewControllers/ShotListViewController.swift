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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 뷰의 레이아웃이 확정된 시점에서 레이아웃을 다시 설정
        configureLayout()
    }

    // 레이아웃 설정 로직을 분리
    private func configureLayout() {
        let minimumSpacing: CGFloat = 10
        let cellItemForRow: CGFloat = 3
        let collectionViewWidth = collectionView.bounds.width
        
        // collectionViewWidth가 0보다 클 때만 계산
        guard collectionViewWidth > 0 else { return }
        
        let width = (collectionViewWidth - (cellItemForRow - 1) * minimumSpacing) / cellItemForRow
        self.flowLayout.itemSize = CGSize(width: width, height: width)
        self.flowLayout.minimumInteritemSpacing = minimumSpacing
        self.flowLayout.minimumLineSpacing = minimumSpacing
    }
    
    func bind(reactor: ShotListViewReactor) {
        rx.viewDidLoad
            .map { ShotListViewReactor.Action.showShotList }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.sections }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(ShotListViewSectionItem.self)
            .subscribe(onNext: { [weak self] sectionItem in
                guard let self else { return }
                let shot = sectionItem.shot
                let shotViewController = self.shotTileCellDependency.shotViewControllerFactory(shot.id, shot)
                self.navigationController?.pushViewController(shotViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
