//
//  ShotViewSection.swift
//  Drrrible
//
//  Created by Suyeol Jeon on 12/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import RxDataSources

enum ShotViewSection {
  case shot([ShotViewSectionItem])
  case comment([ShotViewSectionItem])
}

extension ShotViewSection: SectionModelType {
  var items: [ShotViewSectionItem] {
    switch self {
    case .shot(let items): return items
    case .comment(let items): return items
    }
  }

  init(original: ShotViewSection, items: [ShotViewSectionItem]) {
    switch original {
    case .shot: self = .shot(items)
    case .comment: self = .comment(items)
    }
  }
}

enum ShotViewSectionItem {
  case image(ShotViewImageCellModelType)
  case title(ShotViewTitleCellModelType)
  case text(ShotViewTextCellModelType)
}
