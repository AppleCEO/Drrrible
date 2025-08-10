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
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    var initialState = State()
    
    init(shotService: ShotService, shotCellReactorFactory: @escaping (Shot) -> ShotCellReactor) {
        self.shotService = shotService
        self.shotCellReactorFactory = shotCellReactorFactory
    }
}
