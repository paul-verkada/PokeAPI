public struct PokeAPI {
  public init() {
  }
  
  static public func listPokemon(limit: Int = 20, offset: Int? = nil) async throws(PokemonError) -> [Pokemon] {
    try await PokemonService.listPokemon(limit: limit, offset: offset)
  }
}
