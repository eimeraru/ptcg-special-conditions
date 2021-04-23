import XCTest
@testable import PTCGSpecialConditions

final class PTCGSpecialConditionsTests: XCTestCase {
    
    func testSorted() {
        var tripleCondition = PTCGSpecialConditions()
        tripleCondition.add(with: .burned)
        tripleCondition.add(with: .poisoned(nil))
        tripleCondition.add(with: .asleep)
        XCTAssertEqual([.poisoned(nil), .burned, .asleep], tripleCondition.sorted())
        var doubleCondition = PTCGSpecialConditions()
        doubleCondition.add(with: .paralyzed)
        doubleCondition.add(with: .burned)
        XCTAssertEqual([.burned, .paralyzed], doubleCondition.sorted())
        var oneCondition = PTCGSpecialConditions()
        oneCondition.add(with: .confused)
        XCTAssertEqual([.confused], oneCondition.sorted())
        let empty = PTCGSpecialConditions()
        XCTAssertEqual([], empty.sorted())
    }
    
    func testEqual() {
        var tripleCondition = PTCGSpecialConditions()
        tripleCondition.add(with: .burned)
        tripleCondition.add(with: .poisoned(nil))
        tripleCondition.add(with: .asleep)
        XCTAssertEqual(PTCGSpecialConditions([.burned,
                                              .poisoned(nil),
                                              .asleep]),
                       tripleCondition)
    }

    static var allTests = [
        ("testSorted", testSorted),
    ]
}
