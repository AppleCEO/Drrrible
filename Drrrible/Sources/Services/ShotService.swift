//
//  ShotService.swift
//  Drrrible
//
//  Created by Suyeol Jeon on 09/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import RxSwift

protocol ShotServiceType {
  func shots(paging: Paging) -> Single<List<Shot>>
  func shot(id: Int) -> Single<Shot>
  func isLiked(shotID: Int) -> Single<Bool>
  func like(shotID: Int) -> Single<Void>
  func unlike(shotID: Int) -> Single<Void>
  func comments(shotID: Int) -> Single<List<Comment>>
}

final class ShotService: ShotServiceType {
  fileprivate let networking: DrrribleNetworking

  init(networking: DrrribleNetworking) {
    self.networking = networking
  }

  func shots(paging: Paging) -> Single<List<Shot>> {
    let dummyUser = User(
      id: 1,
      name: "Gemini User",
      avatarURL: URL(string: "https://avatars.githubusercontent.com/u/931655?v=4")!,
      bio: "I am a Gemini user.",
      isPro: false,
      shotCount: 20,
      followerCount: 100,
      followingCount: 50
    )

    let dummyShots = (1...20).map { i -> Shot in
      let imageURLString = "https://picsum.photos/400/300?random=\(i)"
      let teaserURLString = "https://picsum.photos/200/150?random=\(i)"
      return Shot(
        id: i,
        title: "Shot \(i)",
        text: "This is a dummy shot #\(i).",
        user: dummyUser,
        imageURLs: ShotImageURLs(
          hidpi: nil,
          normal: URL(string: imageURLString)!,
          teaser: URL(string: teaserURLString)!
        ),
        imageWidth: 400,
        imageHeight: 300,
        isAnimatedImage: false,
        viewCount: Int.random(in: 100...1000),
        likeCount: Int.random(in: 10...200),
        commentCount: Int.random(in: 5...50),
        createdAt: Date(),
        isLiked: Bool.random()
      )
    }

    let dummyList = List<Shot>(items: dummyShots, nextURL: nil)
    return .just(dummyList)
  }

  func shot(id: Int) -> Single<Shot> {
    return self.networking.request(.shot(id: id)).map(Shot.self)
  }

  func isLiked(shotID: Int) -> Single<Bool> {
    return self.networking.request(.isLikedShot(id: shotID))
      .map { _ in true }
      .catchError { _ in .just(false) }
      .do(onSuccess: { isLiked in
        Shot.event.onNext(.updateLiked(id: shotID, isLiked: isLiked))
      })
  }

  func like(shotID: Int) -> Single<Void> {
    Shot.event.onNext(.updateLiked(id: shotID, isLiked: true))
    Shot.event.onNext(.increaseLikeCount(id: shotID))
    return self.networking.request(.likeShot(id: shotID)).map { _ in }
      .do(onError: { error in
        Shot.event.onNext(.updateLiked(id: shotID, isLiked: false))
        Shot.event.onNext(.decreaseLikeCount(id: shotID))
      })
  }

  func unlike(shotID: Int) -> Single<Void> {
    Shot.event.onNext(.updateLiked(id: shotID, isLiked: false))
    Shot.event.onNext(.decreaseLikeCount(id: shotID))
    return self.networking.request(.unlikeShot(id: shotID)).map { _ in }
      .do(onError: { error in
        Shot.event.onNext(.updateLiked(id: shotID, isLiked: true))
        Shot.event.onNext(.increaseLikeCount(id: shotID))
      })
  }

  func comments(shotID: Int) -> Single<List<Comment>> {
    return self.networking.request(.shotComments(shotID: shotID)).map(List<Comment>.self)
  }
}
