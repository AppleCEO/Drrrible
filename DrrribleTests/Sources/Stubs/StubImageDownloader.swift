//
//  StubImageDownloader.swift
//  Drrrible
//
//  Created by Suyeol Jeon on 23/07/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import Kingfisher

final class StubImageDownloader: ImageDownloader {
  init() {
    super.init(name: "StubImageDownloader")
  }
}

extension Array where Element == KingfisherOptionsInfoItem {
  static func stub(downloader: ImageDownloader? = nil) -> KingfisherOptionsInfo {
    let downloader = downloader ?? StubImageDownloader()
    return [.forceRefresh, .downloader(downloader)]
  }
}
