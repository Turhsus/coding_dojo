//
//  GameScene.swift
//  Space_Shooting
//
//  Created by Tianyu Ying on 7/15/16.
//  Copyright (c) 2016 Tianyu Ying. All rights reserved.
//

import SpriteKit
import CoreMotion
import AVFoundation

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif

extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x * x + y * y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Hero         : UInt32 = 0b1
    static let Monster      : UInt32 = 0b10
    static let Projectile   : UInt32 = 0b11
    static let Monster_Proj : UInt32 = 0b100
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let enemys = ["enemy", "enemy2"]
    
    let spaceship = SKSpriteNode(imageNamed:"Spaceship")
    
    var motionManager = CMMotionManager()
    
    var speedX: UIAccelerationValue = 0
    var speedY: UIAccelerationValue = 0
  
    let scoreLabelHud = "scoreHud"
    var score: Int = 0
    
    var lastTouch: Double = 0.0
    
    override func didMoveToView(view: SKView) {

        makeBackground()
        setupHud()
        
        spaceship.xScale = 0.12
        spaceship.yScale = 0.12
        
        spaceship.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame) * 0.2)
        
        spaceship.physicsBody = SKPhysicsBody(rectangleOfSize: spaceship.size)
        spaceship.physicsBody?.dynamic = true
        spaceship.physicsBody?.categoryBitMask = PhysicsCategory.Hero
        spaceship.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        spaceship.physicsBody?.collisionBitMask = PhysicsCategory.None
        spaceship.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(spaceship)
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        motionManager.accelerometerUpdateInterval = 1/60
        
        if (motionManager.accelerometerAvailable) {
            let queue = NSOperationQueue.currentQueue()
            motionManager.startAccelerometerUpdatesToQueue(queue!, withHandler:
                { (accelerometerData : CMAccelerometerData?, error: NSError?) -> Void in
                    
                    self.speedX += accelerometerData!.acceleration.x
                    let tempY = accelerometerData!.acceleration.y <= 0.0 ? accelerometerData!.acceleration.y + 0.3 : accelerometerData!.acceleration.y

                    self.speedY += tempY
                    
                    var posX = self.spaceship.position.x + CGFloat(self.speedX)
                    var posY = self.spaceship.position.y + CGFloat(self.speedY)

                    if posX < self.spaceship.size.width / 2 {
                        posX = self.spaceship.size.width / 2;
                        self.speedX = 0
                    }
                    else if posX > CGRectGetMaxX(self.frame) - self.spaceship.size.width / 2 {
                        posX = CGRectGetMaxX(self.frame) - self.spaceship.size.width / 2
                        self.speedX = 0
                    }
                    
                    if posY < self.spaceship.size.height / 2 {
                        posY = self.spaceship.size.height / 2
                        
                        self.speedY = 0
                    }
                    else if posY > CGRectGetMaxY(self.frame) - self.spaceship.size.height / 2 {
                        posY = CGRectGetMaxY(self.frame) - self.spaceship.size.height / 2
                        
                        self.speedY = 0
                    }
                    self.spaceship.position = CGPointMake(posX, posY)
            })
        }
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addMonster),
                SKAction.waitForDuration(1.0)
                ])
            ))
        
        backgroundMusic?.play()
    }
    
    lazy var backgroundMusic: AVAudioPlayer? = {
        guard let url = NSBundle.mainBundle().URLForResource("contra", withExtension: "mp3") else {
            return nil
        }
        do {
            let player = try AVAudioPlayer(contentsOfURL: url)
            player.numberOfLoops = -1
            return player
        } catch {
            return nil
        }
    }()
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if NSDate().timeIntervalSince1970 - lastTouch < 0.24 {
            return
        }
        
        lastTouch = NSDate().timeIntervalSince1970
        
        let projectile = SKSpriteNode(imageNamed: "laser")
        
        projectile.xScale = 0.5
        projectile.yScale = 0.5
        
        projectile.position = CGPoint(x: spaceship.position.x, y: spaceship.position.y + spaceship.size.height / 2)
        
        projectile.physicsBody = SKPhysicsBody(rectangleOfSize: projectile.size)
        projectile.physicsBody?.dynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.physicsBody?.usesPreciseCollisionDetection = true
        
        addChild(projectile)
        
        let realDest = CGPoint(x: projectile.position.x, y: size.height + projectile.size.height)
        
        let actionMove = SKAction.moveTo(realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        projectile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    
    func makeBackground() {
        
        let backgroundTexture = SKTexture(imageNamed: "spacebackground")
        
        let shiftBackground = SKAction.moveByX(0, y: -backgroundTexture.size().height, duration: 9)
        let replaceBackground = SKAction.moveByX(0, y:backgroundTexture.size().height, duration: 0)
        let movingAndReplacingBackground = SKAction.repeatActionForever(SKAction.sequence([shiftBackground,replaceBackground]))
        
        var background:SKSpriteNode?
        for i in 0..<3 {
            background=SKSpriteNode(texture:backgroundTexture)
            background?.zPosition = -150
            background!.position = CGPoint(x: CGRectGetMidX(self.frame), y: backgroundTexture.size().height/2 + (backgroundTexture.size().height * CGFloat(i)))
            background!.size.width = self.frame.width
            background!.runAction(movingAndReplacingBackground)
            
            self.addChild(background!)
        }
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
    func addMonster() {
        
        var index = 0
        
        if score >= 25 {
            index = Int(arc4random_uniform(2))
        }
        
        let monster = SKSpriteNode(imageNamed: enemys[index])
        
        if index == 0 {
            monster.xScale = 0.2
            monster.yScale = 0.2
        }
        else {
            monster.xScale = 0.5
            monster.yScale = 0.5
        }
        
        monster.physicsBody = SKPhysicsBody(rectangleOfSize: monster.size)
        monster.physicsBody?.dynamic = true
        monster.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        monster.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile
        monster.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        let actualX = random(min: monster.size.width / 2, max: size.width - monster.size.width / 2)
        
        if index == 0 {
            monster.position = CGPoint(x: actualX, y: size.height + monster.size.height / 2)
        }
        else {
            monster.position = CGPoint(x: actualX, y: -monster.size.height / 2)
        }
        
        addChild(monster)
        
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        
        var moveTo = CGPoint(x: actualX, y: -monster.size.height / 2)
        if index == 1 {
            moveTo = CGPoint(x: actualX, y: size.height + monster.size.height / 2)
        }
        
        let actionMove = SKAction.moveTo(moveTo, duration: NSTimeInterval(actualDuration))
        
        let loseAction = SKAction.runBlock() {
            self.endGame()
        }
        
        let actionMoveDone = SKAction.removeFromParent()
        
        if index == 0 {
            monster.runAction(SKAction.sequence([actionMove, loseAction]))
        }
        else {
            monster.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        }
    }
    
    func projectileDidCollideWithMonster(projectile: SKSpriteNode, monster: SKSpriteNode) {
        projectile.removeFromParent()
        monster.removeFromParent()
    }
  
    func setupHud() {
      // 1
      let scoreLabel = SKLabelNode(fontNamed: "Courier")
      scoreLabel.name = scoreLabelHud
      scoreLabel.fontSize = 25
    
      // 2
      scoreLabel.fontColor = SKColor.greenColor()
      scoreLabel.text = String(format: "Score: %04u", 0)
    
      // 3
      scoreLabel.position = CGPoint(
        x: frame.size.width / 2,
        y: size.height - (40 + scoreLabel.frame.size.height/2)
      )
      addChild(scoreLabel)
    }
    
    func addScoreBy(points: Int) {
        score += points
        
        if let score = childNodeWithName(scoreLabelHud) as? SKLabelNode {
            score.text = String(format: "Score: %04u", self.score)
        }
    }
  
    func didBeginContact(contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == PhysicsCategory.Monster && contact.bodyB.categoryBitMask == PhysicsCategory.Projectile) || (contact.bodyB.categoryBitMask == PhysicsCategory.Monster && contact.bodyA.categoryBitMask == PhysicsCategory.Projectile) {

            var firstBody: SKPhysicsBody
            var secondBody: SKPhysicsBody

            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                firstBody = contact.bodyA
                secondBody = contact.bodyB
            }
            else {
                firstBody = contact.bodyB
                secondBody = contact.bodyA
            }

            if (firstBody.categoryBitMask & PhysicsCategory.Projectile == 2) && (secondBody.categoryBitMask & PhysicsCategory.Monster == 2) {
                
                if firstBody.node != nil && secondBody.node != nil {
                    projectileDidCollideWithMonster(firstBody.node as! SKSpriteNode, monster: secondBody.node as! SKSpriteNode)
                    self.runAction(SKAction.playSoundFileNamed("InvaderHit.wav", waitForCompletion: false))
                    addScoreBy(1)
                   
                }
            }
        }
        else if (contact.bodyA.categoryBitMask == PhysicsCategory.Hero && contact.bodyB.categoryBitMask == PhysicsCategory.Monster) || (contact.bodyB.categoryBitMask == PhysicsCategory.Monster && contact.bodyA.categoryBitMask == PhysicsCategory.Hero) {
            
            var firstBody: SKPhysicsBody
            var secondBody: SKPhysicsBody
            
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                firstBody = contact.bodyA
                secondBody = contact.bodyB
            }
            else {
                firstBody = contact.bodyB
                secondBody = contact.bodyA
            }
            
            
            
            if (firstBody.categoryBitMask & PhysicsCategory.Monster == 0) && (secondBody.categoryBitMask & PhysicsCategory.Hero == 0) {
                
                endGame()
            }
        }
    }
    
    func endGame() {
        backgroundMusic?.stop()
        motionManager.stopAccelerometerUpdates()
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        let gameOverScene = GameOverScene(size: size, score: score)
        self.view?.presentScene(gameOverScene, transition: reveal)
    }
}

