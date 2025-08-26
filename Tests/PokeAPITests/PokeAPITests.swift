import XCTest
@testable import PokeAPI

final class PokeAPITests: XCTestCase {
    func testExample() async throws {
      let pokemons = try await PokeAPI.listPokemon()
      XCTAssertFalse(pokemons.isEmpty)
    }
}
