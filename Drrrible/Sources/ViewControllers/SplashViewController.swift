//
//  SplashViewController.swift
//  Drrrible
//
//  Created by Suyeol Jeon on 07/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

import ReactorKit

final class SplashViewController: BaseViewController, View {

  typealias Reactor = SplashViewReactor


  // MARK: Properties

  private let presentLoginScreen: () -> Void
  private let presentMainScreen: () -> Void


  // MARK: UI

  let logoView = UIImageView(image: #imageLiteral(resourceName: "Icon512"))
  let titleLabel = UILabel().then {
    $0.text = "Loading..."
    $0.font = UIFont.boldSystemFont(ofSize: 60)
      $0.textColor = .black
  }
  fileprivate let activityIndicatorView = UIActivityIndicatorView(style: .gray)


  // MARK: View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    self.view.addSubview(self.logoView)
    self.view.addSubview(self.titleLabel)
    self.activityIndicatorView.startAnimating()
    self.view.addSubview(self.activityIndicatorView)
  }

  override func setupConstraints() {
    self.logoView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(-40)
      make.width.equalTo(225)
      make.height.equalTo(225)
    }
    self.titleLabel.snp.makeConstraints { make in
      make.top.equalTo(self.logoView.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
    }
    self.activityIndicatorView.snp.makeConstraints { make in
      make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
      make.centerX.equalToSuperview()
    }
  }


  // MARK: Initializing

  init(
    reactor: Reactor,
    presentLoginScreen: @escaping () -> Void,
    presentMainScreen: @escaping () -> Void
  ) {
    defer { self.reactor = reactor }
    self.presentLoginScreen = presentLoginScreen
    self.presentMainScreen = presentMainScreen
    super.init()
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Configuring

  func bind(reactor: Reactor) {
    // Action
    self.rx.viewDidAppear
      .map { _ in Reactor.Action.checkIfAuthenticated }
      .bind(to: reactor.action)
      .disposed(by: self.disposeBag)

    // State
    reactor.state.map { $0.isAuthenticated }
      .filterNil()
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] isAuthenticated in
        if !isAuthenticated {
          self?.presentLoginScreen()
        } else {
          self?.presentMainScreen()
        }
      })
      .disposed(by: self.disposeBag)
  }

}
