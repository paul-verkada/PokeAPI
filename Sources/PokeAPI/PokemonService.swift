//
//  PokemonService.swift
//  
//
//  Created by Paul Wong on 3/20/22.
//

import Foundation

public enum PokemonError: Error {
  case jsonParsingFailed(Error)
  case requestFailed(Error)
  case unknown
}

struct PokemonService {
  private static let PokemonURL = "https://pokeapi.co/api/v2/pokemon"
  
  static public func listPokemon(limit: Int = 20, offset: Int? = nil) async throws(PokemonError) -> [Pokemon] {
    var urlComponents = URLComponents(string: PokemonService.PokemonURL)
    var queryItems = [URLQueryItem(name: "limit", value: String(limit))]
    if let offset {
      queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
    }
    urlComponents?.queryItems = queryItems
    guard let url = urlComponents?.url else { throw .unknown }
    
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let listPokemonResponse = try JSONDecoder().decode(ListPokemonResponse.self, from: data)
      
      return await withTaskGroup(of: Pokemon?.self) { group in
        listPokemonResponse.results.forEach { pokemonResponse in
          group.addTask {
            do {
              let pokemon = try await PokemonService.getPokemon(url: pokemonResponse.url)
              return pokemon
            } catch {
              print(error)
              return nil
            }
          }
        }
        
        var pokemons = [Pokemon]()
        for await pokemon in group {
          if let pokemon {
            pokemons.append(pokemon)
          }
        }
        return pokemons
        
      }
    } catch let error as DecodingError {
      throw .jsonParsingFailed(error)
    } catch {
      throw .requestFailed(error)
    }
  }
  
  static func getPokemon(url: URL) async throws(PokemonError) -> Pokemon {
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      let pokemon = try decoder.decode(Pokemon.self, from: data)
      return pokemon
    } catch let error as PokemonError {
      throw error
    } catch let error as DecodingError {
      throw .jsonParsingFailed(error)
    } catch {
      throw .requestFailed(error)
    }
  }
}
