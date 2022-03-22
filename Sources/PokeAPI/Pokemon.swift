//
//  Pokemon.swift
//  
//
//  Created by Paul Wong on 3/20/22.
//

import Foundation

public struct Pokemon: Decodable {
  public let id: Int
  public let name: String
  public let order: Int
  public let sprites: PokemonSprites
}
