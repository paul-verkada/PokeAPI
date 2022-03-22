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
  
  static public func listPokemon(limit: Int = 20,
                                 offset: Int? = nil,
                                 completion: @escaping ((Result<[Pokemon], PokemonError>)) -> Void) -> URLSessionDataTask {
    var urlString = "\(PokemonService.PokemonURL)?limit=\(limit))"
    if let offset = offset {
      urlString += "&offset=\(offset)"
    }
    let url = URL(string: urlString)!
    let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(.requestFailed(error)))
      } else {
        if let data = data {
          do {
            var pokemonResult: [Pokemon] = []
            let dispatchGroup = DispatchGroup()
            let listPokemonResponse = try JSONDecoder().decode(ListPokemonResponse.self, from: data)
            listPokemonResponse.results.forEach { pokemonResponse in
              dispatchGroup.enter()
              let _ = PokemonService.getPokemon(url: pokemonResponse.url) { result in
                switch result {
                case .success(let pokemon):
                  pokemonResult.append(pokemon)
                case .failure(let error):
                  print(error)
                }
                dispatchGroup.leave()
              }
            }
            dispatchGroup.notify(queue: DispatchQueue.global(qos: .userInteractive)) {
              completion(.success(pokemonResult))
            }
          } catch(let error) {
            completion(.failure(.jsonParsingFailed(error)))
          }
        } else {
          completion(.failure(.unknown))
        }
      }
    }
    dataTask.resume()
    return dataTask
  }
  
  static func getPokemon(url: URL, completion: @escaping ((Result<Pokemon, PokemonError>)) -> Void) -> URLSessionDataTask {
    let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(.requestFailed(error)))
      } else {
        if let data = data {
          do {
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            completion(.success(pokemon))
          } catch(let error) {
            completion(.failure(.jsonParsingFailed(error)))
          }
        } else {
          completion(.failure(.unknown))
        }
      }
    }
    dataTask.resume()
    return dataTask
  }
}
