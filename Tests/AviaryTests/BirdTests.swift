import XCTest
@testable import Aviary

final class NanoludeTests: XCTestCase {

    func testIdiot() {
        XCTAssertEqual(λ.Aviary.idiot(42), 42)
    }

    func testKestrel() {
        XCTAssertEqual(λ.Aviary.kestrel(42)(""), 42)
    }

    func testKite() {
        XCTAssertEqual(λ.Aviary.kite("")(42), 42)
    }

    func testIdiotOnceRemoved() {
        XCTAssertEqual(λ.Aviary.idiotOnceRemoved(λ.Aviary.idiot)(42), 42)
    }

    func testIdiotTwiceRemoved() {
        XCTAssertEqual(λ.Aviary.idiotTwiceRemoved(λ.Aviary.idiot)(42)(""), 42)
    }

    func testThrush() {
        let plus42 = partial(__, +, 42)
        XCTAssertEqual(λ.Aviary.thrush(42)(plus42), 84)
    }

    func testVireo() {
        XCTAssertEqual(λ.Aviary.vireo(42)(42)(curry(+)), 84)
    }

    func testVireoOnceRemoved() {
        let f: (String) -> (Int) -> (String) -> String = { s1 in { n in { s2 in
            "\(s1)\(n)\(s2)"
        } } }
        XCTAssertEqual(λ.Aviary.vireoOnceRemoved(f)(42)("[")("]"), "[42]")
    }

    func testVireoTwiceRemoved() {

    }

    func testCardinal() {
        let append = curry(+) ◦ Type.annotate(String.self)
        XCTAssertEqual(
            λ.Aviary.cardinal(append)("World!")("Hello, "),
            "Hello, World!")
    }

    func testFinch() {

    }

    func testFinchOnceRemoved() {

    }

    func testFinchTwiceRemoved() {

    }

    func testRobin() {

    }

    func testRobinOnceRemoved() {

    }

    func testRobinTwiceRemoved() {

    }

    func testWarbler() {

    }

    func testWorbler() {

    }

    func testWarblerOnceRemoved() {

    }

    func testWarblerTwiceRemoved() {

    }

    func testHummingbird() {

    }

    func testBluebird() {

    }

    func testBluebirdPrime() {

    }

    func testBlackbird() {

    }

    func testBunting() {

    }

    func testBecard() {

    }

    func testQueer() {

    }

    func testQuixotic() {

    }

    func testQuizzical() {

    }

    func testQuirky() {

    }

    func testQuacky() {

    }

    func testStarling() {

    }

    func testStarlingPrime() {

    }

    func testPhoenix() {

    }

    func testGoldfinch() {

    }

    func testDove() {

    }

    func testDickcissel() {

    }

    func testDovekie() {

    }

    func testEagle() {

    }

    func testBaldEagle() {

    }

    func testSage() {

    }

    func testJay() {

    }

    func testOwl() {

    }

    func testOwlPrime() {

    }

    func testApplicator() {

    }

    func testJalt() {

    }

    func testJaltPrime() {

    }

    func testPsi() {

    }


    static var allTests = [
        ("testNilType", testNilType),
        ("testConstUnbound", testConstUnbound),
        ("testConst", testConst),
    ]
}
