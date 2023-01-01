//
//  SKObject.swift
//  Arcadia
//
//  Created by Евгений Киреичев on 18.08.2022.
//

import SpriteKit

final class SKObject: SKShapeNode {
    convenience init(type: ObjectType) {
        switch type.shape {
        case .edges(let size):
            self.init(rectOf: size)
            physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        case .rectangle(let size):
            self.init(rectOf: size)
            physicsBody = SKPhysicsBody(rectangleOf: size)
        case .circle(let radius):
            self.init(circleOfRadius: radius)
            physicsBody = SKPhysicsBody(circleOfRadius: radius)
        }

        setupColor(type: type)
        setupPhysicsBody(type: type)
    }
    
    private func setupColor(type: ObjectType) {
        fillColor = type.fillColor
        strokeColor = type.strokeColor
    }
    
    private func setupPhysicsBody(type: ObjectType) {
        physicsBody?.isDynamic = type.isDynamic
        physicsBody?.allowsRotation = type.allowsRotation
        physicsBody?.categoryBitMask = type.categoryBitMask
        physicsBody?.contactTestBitMask = type.contactTestBitMask
        physicsBody?.collisionBitMask = type.collisionBitMask
        physicsBody?.usesPreciseCollisionDetection = type.usesPreciseCollisionDetection
        physicsBody?.friction = type.friction
        physicsBody?.restitution = type.restitution
        physicsBody?.linearDamping = type.linearDamping
    }
}
