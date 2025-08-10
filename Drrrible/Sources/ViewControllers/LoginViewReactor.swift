//
//  LoginViewReactor.swift
//  Drrrible
//
//  Created by 도미닉 on 8/10/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import ReactorKit

class LoginViewReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
    }
    
    var initialState = State()
    
    init(authService: AuthService, userService: UserService) {
    }
}
