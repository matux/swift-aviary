import XCTest
@testable import Aviary

final class NanoludeTests: XCTestCase {

    func testIdentity() {
        XCTAssertEqual(id(42), 42)
        XCTAssertEqual(id(nil as Nil), nil as Nil)
        XCTAssertTrue(id((42, 42)) == (42, 42))
        XCTAssertTrue(id(nil) == nil)
        XCTAssertTrue(id(()) == ())
    }

    func testNilType() {
        XCTAssertTrue(nil as Nil == nil)
        XCTAssertTrue(nil == nil as Nil)

        XCTAssertTrue(nil as Nil == .none as Any?)
        XCTAssertTrue(.none as Any? == nil as Nil)

        XCTAssertTrue(const(nil as Nil)(0) == nil)
        XCTAssertTrue(nil == const(nil as Nil)(""))

        XCTAssertTrue(const(.none as Int?)(1) == nil as Nil)
        XCTAssertTrue(const(nil as Nil)(1) == .none as Int?)
    }

    func testConstUnbound() {
        let k0 = const(())
        XCTAssertTrue(k0(0)      == ())
        XCTAssertTrue(k0(())     == ())
        XCTAssertTrue(k0(nil)    == ())
        XCTAssertTrue(k0(k0(k0)) == ())
        XCTAssertTrue(k0(0.addingReportingOverflow) == ())
        XCTAssertTrue(k0(0.addingReportingOverflow(0)) == ())
    }

    func testConstNil() {
        let k1 = const(nil)
        XCTAssertTrue(k1(0)      == nil)
        XCTAssertTrue(k1(())     == nil)
        XCTAssertTrue(k1(nil)    == nil)
        XCTAssertTrue(k1(k1(k1)) == nil)
        XCTAssertTrue(k1(0.addingReportingOverflow(0)) == nil)

        XCTAssertEqual(const(nil)(0), nil)
        XCTAssertEqual(const(nil as Nil)(0), nil)
    }

    func testConstPartial() {
        let k = (const(0), const(nil), const(()), const((0,0)))
        XCTAssertEqual(k.0(""), 0)
        XCTAssertEqual(k.1(""), nil)
        XCTAssertEqual(k.1(""), nil as Nil)
        XCTAssertTrue(k.2("") == ())
        XCTAssertTrue(k.3("") == (0,0))
    }

    func testConst() {
        XCTAssertEqual(const(0)(1), 0)
        XCTAssertEqual(const(.some(0) as Int?)(1), .some(0))
        XCTAssertEqual(const([3, 32, 93])(""), [3, 32, 93])
        XCTAssertEqual(const("")((4, 2, 42)), "")
        XCTAssertTrue(const((3, "", 2.3))("") == (3, "", 2.3))
    }

    static var allTests = [
        ("testNilType", testNilType),
        ("testConstUnbound", testConstUnbound),
        ("testConst", testConst),
    ]
}
