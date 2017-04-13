//
//  ShotViewReactionCellReactor.swift
//  Drrrible
//
//  Created by Suyeol Jeon on 12/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import RxSwift

import ReactorKit

struct ShotViewReactionComponents: ReactorComponents {
  typealias State = Void
}

final class ShotViewReactionCellReactor: Reactor<ShotViewReactionComponents> {
  let likeButtonViewReactor: ShotViewReactionButtonViewReactor
  let commentButtonViewReactor: ShotViewReactionButtonViewReactor

  init(provider: ServiceProviderType, shot: Shot) {
    self.likeButtonViewReactor = ShotViewReactionLikeButtonViewReactor(
      provider: provider,
      shot: shot
    )
    self.commentButtonViewReactor = ShotViewReactionCommentButtonViewReactor(
      provider: provider,
      shot: shot
    )
    super.init(initialState: Void())
  }
}
