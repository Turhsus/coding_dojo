//
//  GameOverScene.swift
//  spirte_first_try
//
//  Created by Tianyu Ying on 7/8/16.
//  Copyright © 2016 Tianyu Ying. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, won: Bool) {
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
        
        let message = won ? "You Won!" : "You Lose!"
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width / 2, y: size.height / 3 * 2)
        addChild(label)
        
        let label2 = SKLabelNode(fontNamed: "Chalkduster")
        label2.text = "Touch to try again"
        label2.fontSize = 15
        label2.fontColor = SKColor.blackColor()
        label2.position = CGPoint(x: size.width / 2, y: size.height / 5)
        addChild(label2)
        
//        runAction(SKAction.sequence([
//            SKAction.waitForDuration(3.0),
//            SKAction.runBlock() {
//                let reveal = SKTransition.flipVerticalWithDuration(0.5)
//                let scene = GameScene(size: size)
//                self.view?.presentScene(scene, transition: reveal)
//            }
//        ]))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let reveal = SKTransition.flipVerticalWithDuration(0.5)
        let scene = GameScene(size: size)
        self.view?.presentScene(scene, transition: reveal)
    }
}