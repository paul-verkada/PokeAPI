//
//  ListPokemonResponse.swift
//  
//
//  Created by Paul Wong on 3/20/22.
//

import Foundation

struct ListPokemonResponse: Decodable {
  let count: Int
  let next: String?
  let previous: String?
  let results: [PokemonResult]
}
