//
//  ObjectType.swift
//  Arcadia
//
//  Created by Евгений Киреичев on 02.07.2022.
//

import UIKit

enum ObjectType: Equatable {
    case court
    case ball
    case slider(Player)
    case goal(Player)
    case brick
}

extension ObjectType {
    enum Shape {
        case edges(size: CGSize)
        case rectangle(size: CGSize)
        case circle(radius: CGFloat)
    }
    
    var shape: Shape {
        switch self {
        case .court:
            return .edges(size: CGSize(width: Sizes.Court.width, height: Sizes.Court.height))
        case .ball:
            return .circle(radius: Sizes.Ball.radius)
        case .slider:
            return .rectangle(size: CGSize(width: Sizes.Slider.Rectangle.width, height: Sizes.Slider.Rectangle.height))
        case .goal:
            return .rectangle(size: CGSize(width: Sizes.Goal.width, height: Sizes.Goal.height))
        case .brick:
            return .rectangle(size: CGSize(width: Sizes.Brick.width, height: Sizes.Brick.height))
        }
    }
}

extension ObjectType {
    var fillColor: UIColor {
        switch self {
        case .court:
            return .systemGreen
        case .ball:
            return .red
        case .slider:
            return .black
        case .goal:
            return .systemYellow
        case .brick:
            return .blue
        }
    }
    
    var strokeColor: UIColor {
        .black
    }
}

extension ObjectType {
    var isDynamic: Bool {
        switch self {
        case .ball, .slider:
            return true
        case .court, .goal, .brick:
            return false
        }
    }
    
    var allowsRotation: Bool {
        false
    }
    
    var contactTestBitMask: UInt32 {
        switch self {
        case .ball:
            return PhysicsCategory.brick
        case .brick:
            return PhysicsCategory.ball
        case .court, .slider, .goal:
            return PhysicsCategory.none
        }
    }
    
    var collisionBitMask: UInt32 {
        PhysicsCategory.all
    }
    
    var categoryBitMask: UInt32 {
        switch self {
        case .court:
            return PhysicsCategory.court
        case .ball:
            return PhysicsCategory.ball
        case .slider:
            return PhysicsCategory.slider
        case .brick:
            return PhysicsCategory.brick
        case .goal:
            return PhysicsCategory.none
        }
    }
    
    var usesPreciseCollisionDetection: Bool {
        switch self {
        case .ball, .slider:
            return true
        case .court, .goal, .brick:
            return false
        }
    }
    
    var friction: CGFloat {
        switch self {
        case .court:
            return 0.0
        case .ball:
            return 0.1
        case .slider:
            return 0.1
        case .goal, .brick:
            return 0.0
        }
    }
    
    var restitution: CGFloat {
        switch self {
        case .court:
            return 0.9
        case .ball:
            return 0.9
        case .slider:
            return 0.0
        case .brick:
            return 0.9
        case .goal:
            return 0.0
        }
    }
    
    var linearDamping: CGFloat {
        switch self {
        case .court:
            return 0.0
        case .ball:
            return 0.1
        case .slider:
            return 1.0
        case .goal, .brick:
            return 0.0
        }
    }
}
