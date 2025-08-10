//
//  SplashViewReactor.swift
//  Drrrible
//
//  Created by 도미닉 on 8/10/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import ReactorKit
import RxSwift

final class SplashViewReactor: Reactor {
    enum Action {
        case start
    }
    
    enum Mutation {
        case setNotAuthorization
    }
    
    struct State {
        var isAuthorization: Bool
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(isAuthorization: false)
    }
}
