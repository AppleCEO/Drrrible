//
//  LoginViewController.swift
//  Drrrible
//
//  Created by 도미닉 on 8/10/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import ReactorKit
import UIKit

final class LoginViewController: BaseViewController, View {
    private let analytics: DrrribleAnalytics
    private let presentMainScreen: () -> Void
    private let loginButton = UIButton().then { button in
        button.backgroundColor = .red
        button.tintColor = .white
        button.setTitle("로그인", for: .normal)
    }
    
    func bind(reactor: LoginViewReactor) {
        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.analytics.log(.login)
                self?.presentMainScreen()
            })
            .disposed(by: disposeBag)
    }
    
    init(reactor: LoginViewReactor,
         analytics: DrrribleAnalytics,
         presentMainScreen: @escaping () -> Void) {
        self.analytics = analytics
        self.presentMainScreen = presentMainScreen
        super.init()
        self.reactor = reactor
    }
    
    @MainActor required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
