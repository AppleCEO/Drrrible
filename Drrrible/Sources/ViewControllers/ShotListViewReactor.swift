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
        case setShots([Shot])
    }
    
    struct State {
        var sections: [ShotListViewSection] = [.shotTile([])]
    }
    
    var initialState = State()
    
    init(shotService: ShotService, shotCellReactorFactory: @escaping (Shot) -> ShotCellReactor) {
        self.shotService = shotService
        self.shotCellReactorFactory = shotCellReactorFactory
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .showShotList:
            return shotService.shots(paging: .refresh)
                .asObservable()
                .map { Mutation.setShots($0.items) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setShots(let shots):
            let sectionItems = self.shotTileSectionItems(with: shots)
            newState.sections = [.shotTile(sectionItems)]
        }
        return newState
    }
    
    private func shotTileSectionItems(with shots: [Shot]) -> [ShotListViewSectionItem] {
      return shots
        .map(self.shotCellReactorFactory)
        .map(ShotListViewSectionItem.shotTile)
    }
}
