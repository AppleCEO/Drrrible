//
//  UIImageView+Kingfisher.swift
//  Drrrible
//
//  Created by Suyeol Jeon on 01/05/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

import Kingfisher
import RxCocoa
import RxSwift

typealias ImageOptions = KingfisherOptionsInfo

enum ImageResult {
  case success(UIImage)
  case failure(Error)

  var image: UIImage? {
    if case .success(let image) = self {
      return image
    } else {
      return nil
    }
  }

  var error: Error? {
    if case .failure(let error) = self {
      return error
    } else {
      return nil
    }
  }
}

//extension UIImageView {
//  @discardableResult
//  func setImage(
//    with resource: Resource?,
//    placeholder: UIImage? = nil,
//    options: ImageOptions? = nil,
//    progress: ((Int64, Int64) -> Void)? = nil,
//    completion: ((ImageResult) -> Void)? = nil
//  ) -> DownloadTask? {
//    var options = options ?? []
//    // GIF will only animates in the AnimatedImageView
//    if self is AnimatedImageView == false {
//      options.append(.onlyLoadFirstFrame)
//    }
//      
//      typealias CompletionHandler = ((Result<UIImage, KingfisherError>?) -> Void) // Kingfisher 5 이상에서는 Result를 직접 인자로 받습니다.
//
//      // 이건 Kingfisher 7.12.0의 setImage completionHandler에는 맞지 않습니다.
//      let completionHandler: CompletionHandler = { image, error, cacheType, url in
//          if let image = image {
//              completion?(.success(image))
//          } else if let error = error {
//              completion?(.failure(error))
//          }
//      }
//      
//    return self.kf.setImage(
//      with: resource,
//      placeholder: placeholder,
//      options: options,
//      progressBlock: progress,
//      completionHandler: completionHandler
//    )
//  }
//}


//import Kingfisher
//import UIKit

// ImageResult가 무엇인지 정의되어 있지 않아서 예시로 Result<UIImage, Error>로 가정합니다.
// 실제 프로젝트에서 사용하고 계신 ImageResult 타입으로 변경해주세요.
// 예를 들어, Kingfisher의 Result 타입을 재정의한 것이라면 다음과 같을 수 있습니다.
// public typealias ImageResult = Result<UIImage, Error>

// 만약 ImageResult가 별도의 enum이나 struct라면 해당 정의가 필요합니다.
// 예시:
//public enum ImageResult {
//    case success(UIImage)
//    case failure(Error)
//}


extension UIImageView {
    @discardableResult
    func setImage(
        with resource: Resource?,
        placeholder: UIImage? = nil,
        options: KingfisherOptionsInfo? = nil, // ImageOptions 대신 KingfisherOptionsInfo 사용
        progress: ((Int64, Int64) -> Void)? = nil,
        completion: ((ImageResult) -> Void)? = nil
    ) -> DownloadTask? {
        
        var options = options ?? []
        // GIF는 AnimatedImageView에서만 애니메이션됩니다.
        if self is AnimatedImageView == false {
            options.append(.onlyLoadFirstFrame)
        }
        
        // Kingfisher 7.x의 `completionHandler`는 `Result<RetrieveImageResult, KingfisherError>`를 받습니다.
        // 이를 당신의 `completion: ((ImageResult) -> Void)?` 타입에 맞춰 변환합니다.
        let kingfisherCompletionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = { result in
            // 외부 `completion` 클로저가 nil이 아닌 경우에만 처리합니다.
            guard let completion = completion else { return }

            switch result {
            case .success(let retrieveImageResult):
                // Kingfisher의 성공 결과를 당신의 `ImageResult.success`로 변환합니다.
                completion(.success(retrieveImageResult.image))
            case .failure(let error):
                // Kingfisher의 실패 결과를 당신의 `ImageResult.failure`로 변환합니다.
                completion(.failure(error))
            }
        }
        
        return self.kf.setImage(
            with: resource,
            placeholder: placeholder,
            options: options,
            progressBlock: progress,
            completionHandler: kingfisherCompletionHandler // 변환된 핸들러 전달
        )
    }
}

extension Reactive where Base: UIImageView {
  func image(placeholder: UIImage? = nil, options: ImageOptions) -> Binder<Resource?> {
    return Binder(self.base) { imageView, resource in
      imageView.setImage(with: resource, placeholder: placeholder, options: options)
    }
  }
}
