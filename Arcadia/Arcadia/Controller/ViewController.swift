//
//  SKViewController.swift
//  Arcadia
//
//  Created by Евгений Киреичев on 18.08.2022.
//

import SpriteKit

final class ViewController: UIViewController {
    private static let bricksCount = 50

    private var isViewAppeared = false
    
    private let skView = SKView()
    private let skScene = SKScene()
    
    private let court = SKObject(type: .court)
    private let ball = SKObject(type: .ball)
    private let bottomSlider = SKObject(type: .slider(.bottomPlayer))

    private let bricks: [SKObject] = {
        var bricks = [SKObject]()
        for _ in 0..<bricksCount {
            bricks.append(SKObject(type: .brick))
        }
        return bricks
    }()
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapGesture))
    private lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPanGesture))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(skView)
        skView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skView.topAnchor.constraint(equalTo: view.topAnchor),
            skView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            skView.leftAnchor.constraint(equalTo: view.leftAnchor),
            skView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        skView.showsPhysics = true
        skView.addGestureRecognizer(tapGesture)
        skView.addGestureRecognizer(panGesture)
        
        skView.presentScene(skScene)
        skScene.scaleMode = .resizeFill
        skScene.size = skView.frame.size
        skScene.backgroundColor = SKColor.lightGray
        
        skScene.physicsWorld.gravity = .zero
        skScene.physicsWorld.contactDelegate = self
        
        skScene.addChild(court)
        skScene.addChild(ball)
        skScene.addChild(bottomSlider)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        court.position = CGPoint(x: skScene.size.width / 2, y: skScene.size.height / 2)
        ball.position = court.position
        bottomSlider.position = CGPoint(x: skScene.size.width / 2, y: skScene.size.height * 0.15)
        
        placeBricks()
        
        isViewAppeared = true
    }

    @objc
    private func onTapGesture() {
        ball.physicsBody?.isResting = true
        ball.position = court.position
        
        placeBricks()
    }
    
    @objc
    private func onPanGesture(_ recognizer: UIPanGestureRecognizer) {
        let panTranslationX = recognizer.translation(in: skView).x.rounded()
        let panTranslationY = -1 * recognizer.translation(in: skView).y.rounded()

        bottomSlider.physicsBody?.velocity = CGVector(dx: panTranslationX * 60, dy: panTranslationY * 60)
        
        recognizer.setTranslation(.zero, in: skView)
    }
    
    private func placeBricks() {
        for index in 0..<bricks.count {
            let xOffset = Sizes.Brick.width * CGFloat(index % 10)
            let yOffset = Sizes.Brick.height * CGFloat(index / 10)
            placeBrick(bricks[index], xOffset: xOffset, yOffset: yOffset)
        }
    }
    
    private func placeBrick(_ brick: SKShapeNode, xOffset: CGFloat, yOffset: CGFloat) {
        if brick.parent == nil {
            skScene.addChild(brick)
            brick.position = CGPoint(x: Sizes.Brick.width / 2 + xOffset, y: skScene.size.height - 150.0 - yOffset)
        }
    }
}

extension ViewController: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard isViewAppeared else { return }
        
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        let categoryA = bodyA.categoryBitMask
        let categoryB = bodyB.categoryBitMask
        
        switch (categoryA, categoryB) {
        case (PhysicsCategory.ball, PhysicsCategory.brick):
            bodyB.node?.removeFromParent()
        case (PhysicsCategory.brick, PhysicsCategory.ball):
            bodyA.node?.removeFromParent()
        default:
            return
        }
    }
}
