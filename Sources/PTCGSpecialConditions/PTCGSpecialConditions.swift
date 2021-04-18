//
//  PTCGSpecialConditions.swift
//  PTCGSpecialConditions
//
//  Created by Eimer on 2021/04/18.
//

import Foundation

public struct PTCGSpecialConditions {

    private var state: [Layer : PTCGSpecialCondition] = [:]

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
    
    public func sorted() -> Array<PTCGSpecialCondition> {
        return state.keys.compactMap({ state[$0] }).sorted { (lhs, rhs) -> Bool in
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

extension PTCGSpecialConditions.Layer: Equatable {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
