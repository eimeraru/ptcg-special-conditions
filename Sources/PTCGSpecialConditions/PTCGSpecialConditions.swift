//
//  PTCGSpecialConditions.swift
//  PTCGSpecialConditions
//
//  Created by Eimer on 2021/04/18.
//

import Foundation

public struct PTCGSpecialConditions {

    private var state: [Layer : PTCGSpecialCondition] = [:]

    public init(_ conditions: Array<PTCGSpecialCondition> = []) {
        self.state = conditions
            .reduce(into: [Layer : PTCGSpecialCondition](), { ret, c in
                ret[self.layer(with: c)] = c
            })
    }
    
    public mutating func add(with specialCondition: PTCGSpecialCondition) {
        switch specialCondition {
        case .poisoned:
            state[.poisoned] = specialCondition
        case .burned:
            state[.burned] = specialCondition
        case .paralyzed, .asleep, .confused:
            state[.rotation] = specialCondition
        }
    }
    
    public var all: Array<PTCGSpecialCondition> {
        state.keys.compactMap({ state[$0] })
    }
    
    public func sorted() -> Array<PTCGSpecialCondition> {
        all.sorted { (lhs, rhs) -> Bool in
            (lhs.checkPriority ?? 0) > (rhs.checkPriority ?? 0)
        }
    }
}

extension PTCGSpecialConditions {
    public enum Layer: Hashable {
        /**
         * 「どく」の状態
         */
        case poisoned
        /**
         * 「やけど」の状態
         */
        case burned
        /**
         * カードの向きによって表せる状態 (e.g. 横向き: 「ねむり」・「マヒ」、逆向き:「こんらん」)
         */
        case rotation
    }

    /**
     * 状態異常区分
     */
    public func layer(with specialCondition: PTCGSpecialCondition) -> Layer {
        switch specialCondition {
        case .poisoned(_):
            return .poisoned
        case .burned:
            return .burned
        case .asleep, .paralyzed, .confused:
            return .rotation
        }
    }
}

extension PTCGSpecialConditions: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.sorted() == rhs.sorted()
    }
}


extension PTCGSpecialConditions.Layer: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
