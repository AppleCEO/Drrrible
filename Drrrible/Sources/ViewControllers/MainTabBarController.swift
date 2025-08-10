//
//  MainTabBarController.swift
//  Drrrible
//
//  Created by 도미닉 on 8/10/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import UIKit
import ReactorKit

class MainTabBarController: UITabBarController, View {
    var disposeBag = DisposeBag()
    let shotListViewController: ShotListViewController
    let settingsViewController: SettingsViewController
    
    func bind(reactor: MainTabBarViewReactor) {
          
    }
    init(reactor: MainTabBarViewReactor,
         shotListViewController: ShotListViewController,
         settingsViewController: SettingsViewController) {
        self.shotListViewController = shotListViewController
        self.settingsViewController = settingsViewController
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addVC()
    }
    
    private func addVC() {
        let firstVC = UINavigationController(
            rootViewController: shotListViewController
        )
        
        let secondVC = UINavigationController(
            rootViewController: settingsViewController
        )
        
        self.viewControllers = [firstVC, secondVC]
    }
}
