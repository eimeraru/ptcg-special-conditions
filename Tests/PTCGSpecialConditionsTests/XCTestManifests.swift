import XCTest
@testable import PTCGSpecialConditions

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PTCGSpecialConditionTests.allTests),
        testCase(PTCGSpecialConditionsTests.allTests),
    ]
}
#endif
