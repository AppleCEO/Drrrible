//
//  ShotListViewReactor.swift
//  Drrrible
//
//  Created by 도미닉 on 8/10/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import ReactorKit

class ShotListViewReactor: Reactor {
    private let shotService: ShotService
    private let shotCellReactorFactory: (Shot) -> ShotCellReactor
    
    enum Action {
        case showShotList
    }
    
    enum Mutation {
        case setShots(List<Shot>)
    }
    
    struct State {
        var shots: List<Shot>
    }
    
    var initialState = State(shots: .init(items: []))
    
    init(shotService: ShotService, shotCellReactorFactory: @escaping (Shot) -> ShotCellReactor) {
        self.shotService = shotService
        self.shotCellReactorFactory = shotCellReactorFactory
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .showShotList:
            return shotService.shots(paging: .refresh)
                .asObservable()
                .map { Mutation.setShots($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setShots(let shots):
            newState.shots = shots
        }
        return newState
    }
}
