//
//  ShotListViewController.swift
//  Drrrible
//
//  Created by 도미닉 on 8/10/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import UIKit
import ReactorKit

class ShotListViewController: BaseViewController, View {
    let analytics: DrrribleAnalytics
    let shotTileCellDependency: ShotTileCell.Dependency
    
    init(
        reactor: ShotListViewReactor,
        analytics: DrrribleAnalytics,
        shotTileCellDependency: ShotTileCell.Dependency
    ) {
        self.analytics = analytics
        self.shotTileCellDependency = shotTileCellDependency
        super.init()
        self.reactor = reactor
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: ShotListViewReactor) {
        
    }
}
