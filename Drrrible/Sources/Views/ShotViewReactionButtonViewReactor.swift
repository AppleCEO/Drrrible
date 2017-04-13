//
//  ShotViewReactionButtonViewReactor.swift
//  Drrrible
//
//  Created by Suyeol Jeon on 12/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import ReactorKit
import RxSwift

struct ShotViewReactionButtonViewComponents: ReactorComponents {
  enum Action {
    case toggleReaction
    case shotEvent(Shot.Event)
  }

  enum Mutation {
    case setReacted(Bool)
  }

  struct State {
    var isReacted: Bool
    var canToggleReaction: Bool
    var text: String
  }
}

class ShotViewReactionButtonViewReactor: Reactor<ShotViewReactionButtonViewComponents> {
  override func transform(action: Observable<Action>) -> Observable<Action> {
    let shotEvent = Shot.event.map { Action.shotEvent($0) }
    return Observable.of(action, shotEvent).merge()
  }

  override func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case let .setReacted(isReacted):
      state.isReacted = isReacted
      return state
    }
  }
}
