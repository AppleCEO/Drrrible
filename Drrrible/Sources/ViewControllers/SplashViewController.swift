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
    private let loginButton = UIButton().then { button in
        button.backgroundColor = .red
        button.tintColor = .white
        button.setTitle("로그인", for: .normal)
    }
    
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
    
    override func viewDidLoad() {
        configureUI()
    }
    
    func bind(reactor: SplashViewReactor) {
        
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
