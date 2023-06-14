//
//  AppGroup.swift
//  RickAndMorty
//
//  Created by Christopher Alford on 13/6/23.
//

import Foundation

public enum AppGroup: String {
  case rickAndMorty = "group.digital.marine.rickandmorty"

  public var containerURL: URL {
    switch self {
    case .rickAndMorty:
      return FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: self.rawValue)!
    }
  }
}
