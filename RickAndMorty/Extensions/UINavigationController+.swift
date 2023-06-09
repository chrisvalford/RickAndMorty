//
//  UINavigationController+.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 8/6/23.
//

import UIKit

extension UINavigationController {

  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    navigationBar.topItem?.backButtonDisplayMode = .minimal
  }

}
