//
//  LoginViewReactor.swift
//  Drrrible
//
//  Created by 도미닉 on 8/10/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import ReactorKit

class LoginViewReactor: Reactor {
    enum Action {
        case login
    }
    
    enum Mutation {
        case setLoggedIn
    }
    
    struct State {
        var isLoggedIn = false
    }
    
    var initialState = State()
    
    init(authService: AuthService, userService: UserService) {
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .login:
            return Observable<Mutation>.just(.setLoggedIn)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setLoggedIn:
            newState.isLoggedIn = true
        }
        return newState
    }
}
