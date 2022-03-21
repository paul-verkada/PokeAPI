import XCTest
@testable import PokeAPI

final class PokeAPITests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PokeAPI().text, "Hello, World!")
    }
}
