public struct PokeAPI {
  public init() {
  }
  
  static public func listPokemon(limit: Int = 20,
                                 offset: Int? = nil,
                                 completion: @escaping ((Result<[Pokemon], PokemonError>)) -> Void) {
    let _ = PokemonService.listPokemon(limit: limit, offset: offset, completion: completion)
  }
}
