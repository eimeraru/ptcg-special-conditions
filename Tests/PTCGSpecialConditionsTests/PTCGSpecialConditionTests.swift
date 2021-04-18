import XCTest
@testable import PTCGSpecialConditions

final class PTCGSpecialConditionTests: XCTestCase {
    
    func testAllSpecialConditionsName() {
        XCTAssertEqual("どく", PTCGSpecialCondition.poisoned(nil).name)
        XCTAssertEqual("やけど", PTCGSpecialCondition.burned.name)
        XCTAssertEqual("マヒ", PTCGSpecialCondition.paralyzed.name)
        XCTAssertEqual("ねむり", PTCGSpecialCondition.asleep.name)
        XCTAssertEqual("こんらん", PTCGSpecialCondition.confused.name)
    }
    
    func testPoisonedCondition() {
        let condition = PTCGSpecialCondition.poisoned(nil)
        XCTAssertEqual(10, condition.damagePoint)
        XCTAssertEqual(true, condition.canEscaping)
        XCTAssertEqual(true, condition.canUsingSkill)
    }
    
    func testBurnedCondition() {
        let condition = PTCGSpecialCondition.burned
        XCTAssertEqual(20, condition.damagePoint)
        XCTAssertEqual(true, condition.canEscaping)
        XCTAssertEqual(true, condition.canUsingSkill)
    }
    
    func testParalyzedConditions() {
        let condition = PTCGSpecialCondition.paralyzed
        XCTAssertEqual(nil, condition.damagePoint)
        XCTAssertEqual(false, condition.canEscaping)
        XCTAssertEqual(false, condition.canUsingSkill)
    }
    
    func testAsleepConditions() {
        let condition = PTCGSpecialCondition.asleep
        XCTAssertEqual(nil, condition.damagePoint)
        XCTAssertEqual(false, condition.canEscaping)
        XCTAssertEqual(false, condition.canUsingSkill)
    }
    
    func testConfusedConditions() {
        let condition = PTCGSpecialCondition.confused
        XCTAssertEqual(30, condition.damagePoint)
        XCTAssertEqual(true, condition.canEscaping)
        XCTAssertEqual(true, condition.canUsingSkill)
    }

    static var allTests = [
        ("testAllSpecialConditionsName", testAllSpecialConditionsName),
        ("testPoisonedCondition", testPoisonedCondition),
        ("testBurnedCondition", testBurnedCondition),
        ("testParalyzedConditions", testParalyzedConditions),
        ("testAsleepConditions", testAsleepConditions),
        ("testConfusedConditions", testConfusedConditions),
    ]
}
