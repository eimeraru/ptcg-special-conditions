import XCTest
@testable import PTCGSpecialConditions

final class PTCGSpecialConditionsTests: XCTestCase {
    func testAllSpecialConditionsName() {
        XCTAssertEqual(PTCGSpecialConditions.poisoned(10).name, "どく")
        XCTAssertEqual(PTCGSpecialConditions.burned.name, "やけど")
        XCTAssertEqual(PTCGSpecialConditions.paralyzed.name, "マヒ")
        XCTAssertEqual(PTCGSpecialConditions.asleep.name, "ねむり")
        XCTAssertEqual(PTCGSpecialConditions.confused.name, "こんらん")
    }

    static var allTests = [
        ("testAllSpecialConditionsName", testAllSpecialConditionsName),
    ]
}
