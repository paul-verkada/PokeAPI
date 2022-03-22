//
//  PokemonResult.swift
//  
//
//  Created by Paul Wong on 3/20/22.
//

import Foundation

struct PokemonResult: Decodable  {
  let name: String
  let url: URL
  
  enum CodingKeys: String, CodingKey {
    case name
    case url
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    url = try container.decode(URL.self, forKey: .url)
  }
}
