//
//  ShotViewController.swift
//  Drrrible
//
//  Created by 도미닉 on 8/11/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import UIKit
import RxCocoa
import ReactorKit

class ShotViewController: BaseViewController, View {
    private let analytics: DrrribleAnalytics
    private let shotSectionDelegateFactory: () -> Void
    
    func bind(reactor: ShotViewReactor) {
        
    }
    
    init(reactor: ShotViewReactor,
         analytics: DrrribleAnalytics,
         shotSectionDelegateFactory: @escaping () -> Void) {
        self.analytics = analytics
        self.shotSectionDelegateFactory = shotSectionDelegateFactory
        super.init()
        self.reactor = reactor
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

