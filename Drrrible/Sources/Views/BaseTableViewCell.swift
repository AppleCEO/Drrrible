//
//  BaseTableViewCell.swift
//  Dribbblr
//
//  Created by Suyeol Jeon on 10/03/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

import RxSwift

class BaseTableViewViewCell: UITableViewCell {

  // MARK: Initializing

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required convenience init?(coder aDecoder: NSCoder) {
    self.init(style: .default, reuseIdentifier: nil)
  }

}
