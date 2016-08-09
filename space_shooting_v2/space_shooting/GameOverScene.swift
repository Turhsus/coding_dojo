//
//  GameOverScene.swift
//  spirte_first_try
//
//  Created by Tianyu Ying on 7/8/16.
//  Copyright © 2016 Tianyu Ying. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, score: Int) {
        super.init(size: size)
        
        self.runAction(SKAction.playSoundFileNamed("Grenade.wav", waitForCompletion: false))
        
        backgroundColor = SKColor.whiteColor()
        
        let message = "GAME OVER"
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width / 2, y: size.height / 3 * 2)
        addChild(label)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        var highScore = 0
        if let tempScore = defaults.objectForKey("high_score") {
            highScore = tempScore as! Int
        }
        
        let labelCurrScore = SKLabelNode(fontNamed: "Chalkduster")
        labelCurrScore.text = String(format: "YOUR SCORE: %04u", score)
        labelCurrScore.fontSize = 25
        labelCurrScore.fontColor = SKColor.blackColor()
        labelCurrScore.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(labelCurrScore)
        
        let labelHighest = SKLabelNode(fontNamed: "Chalkduster")
        if score >= highScore {
            labelHighest.text = "NEW HIGH SCORE"
            defaults.setObject(score, forKey: "high_score")
        }
        else {
            labelHighest.text = String(format: "HIGH SCORE: %04u", highScore)
        }
        labelHighest.fontSize = 25
        labelHighest.fontColor = SKColor.blackColor()
        labelHighest.position = CGPoint(x: size.width / 2, y: size.height / 3)
        addChild(labelHighest)

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