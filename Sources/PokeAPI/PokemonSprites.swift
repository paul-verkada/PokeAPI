//
//  PokemonSprites.swift
//  
//
//  Created by Paul Wong on 3/20/22.
//

import Foundation

public struct PokemonSprites: Decodable {
  public let frontDefault: URL
  public let frontShiny: URL
  public let backDefault: URL
  public let backShiny: URL
}
