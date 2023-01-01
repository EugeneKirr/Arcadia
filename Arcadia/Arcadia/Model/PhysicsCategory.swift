//
//  PhysicsCategory.swift
//  Arcadia
//
//  Created by Евгений Киреичев on 19.08.2022.
//

import Foundation

struct PhysicsCategory {
    static var none: UInt32     { 0 }
    static var all: UInt32      { UInt32.max }

    static var court: UInt32    { 0b0001 }
    static var ball: UInt32     { 0b0010 }
    static var slider: UInt32   { 0b0100 }
    static var brick: UInt32    { 0b1000 }
}
