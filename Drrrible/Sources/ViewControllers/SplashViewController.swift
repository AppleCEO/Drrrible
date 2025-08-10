//
//  SplashViewController.swift
//  Drrrible
//
//  Created by 도미닉 on 8/10/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import ReactorKit
import RxSwift
import RxCocoa

final class SplashViewController: BaseViewController, View {
    private let presentMainScreen: (() -> Void)
    private let presentLoginScreen: (() -> Void)
    
    init(reactor: SplashViewReactor,
         presentLoginScreen: @escaping () -> Void,
         presentMainScreen: @escaping () -> Void) {
        self.presentLoginScreen = presentLoginScreen
        self.presentMainScreen = presentMainScreen
        super.init()
        self.reactor = reactor
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: SplashViewReactor) {
        rx.viewWillAppear
            .map { _ in SplashViewReactor.Action.start }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state.map { $0.isAuthorization }
            .subscribe(onNext: { [weak self] isAuthorization in
                if isAuthorization {
                    self?.presentMainScreen()
                } else {
                    self?.presentLoginScreen()
                }
            })
            .disposed(by: disposeBag)
    }
}
