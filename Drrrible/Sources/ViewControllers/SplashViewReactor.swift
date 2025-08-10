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
    private let userService: UserService
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
    
    init(userService: UserService) {
        self.initialState = State(isAuthorization: false)
        self.userService = userService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .start:
            return Observable<Mutation>
                .just(Mutation.setNotAuthorization)
                .delay(.seconds(2), scheduler: MainScheduler.instance)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setNotAuthorization:
            newState.isAuthorization = false
        }
        return newState
    }
}
