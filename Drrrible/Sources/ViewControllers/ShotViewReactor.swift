//
//  ShotViewReactor.swift
//  Drrrible
//
//  Created by 도미닉 on 8/11/25.
//  Copyright © 2025 Suyeol Jeon. All rights reserved.
//

import ReactorKit

class ShotViewReactor: Reactor {
    private let shotService: ShotService
    private let shotSectionReactorFactory: (Int, Shot?) -> ShotSectionReactor
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        var shotID: Int
        var shot: Shot?
    }
    
    var initialState: State
    
    init(shotID: Int,
         shot: Shot?,
         shotService: ShotService,
         shotSectionReactorFactory: @escaping (Int, Shot?) -> ShotSectionReactor) {
        self.initialState = State(shotID: shotID, shot: shot)
        self.shotService = shotService
        self.shotSectionReactorFactory = shotSectionReactorFactory
    }
}
