//
//  GameOverScreen.swift
//  spritekitTest190
//
//  Created by Max Takano on 10/14/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, won:Bool, seconds:Int, minutes:Int) {
        
        super.init(size: size)
        
        // 1
        backgroundColor = SKColor.whiteColor()
        
        if (won) {
            let winlabel = SKLabelNode(fontNamed: "Chalkduster")
            winlabel.text = "Beat Your"
            winlabel.fontSize = 40
            winlabel.fontColor = SKColor.blackColor()
            winlabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.8)
            addChild(winlabel)
            let label2 = SKLabelNode(fontNamed: "Chalkduster")
            label2.text = "Best Time!"
            label2.fontSize = 40
            label2.fontColor = SKColor.blackColor()
            label2.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
            addChild(label2)
        } else {
            let loselabel = SKLabelNode(fontNamed: "Chalkduster")
            loselabel.text = "You Died D="
            loselabel.fontSize = 40
            loselabel.fontColor = SKColor.blackColor()
            loselabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.7)
            addChild(loselabel)
        }
        
        
        // 3
        let scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "TimeLasted:"
        scoreLabel.fontSize = 40
        scoreLabel.fontColor = SKColor.blackColor()
        scoreLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(scoreLabel)
        
        let timeLabel = SKLabelNode(fontNamed: "Chalkduster")
        timeLabel.text = "\(minutes/60):\(seconds)"
        timeLabel.fontSize = 40
        timeLabel.fontColor = SKColor.blackColor()
        timeLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.3)
        addChild(timeLabel)
        
        /*let gameOverInfo = UILabel(frame: CGRectMake(size.width * 0.5, size.width * 0.5, size.width * 0.5, size.width * 0.5))
        gameOverInfo.font = UIFont(name: "Chalkduster", size: 40)
        gameOverInfo.textColor = UIColor.redColor()
        gameOverInfo.text = "You Died D= // TimeLasted: \(minutes/60):\(seconds)"
        var framePosition = gameOverInfo.frame;
        framePosition.origin.y = size.width * 0.5;//pass the cordinate which you want
        framePosition.origin.x = size.width * 0.7;//pass the cordinate which you want
        gameOverInfo.frame = framePosition;
        
        
        view?.addSubview(gameOverInfo)*/

        // 4
        runAction(SKAction.sequence([
            SKAction.waitForDuration(3.0),
            SKAction.runBlock() {
                // 5
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene = GameScene(size: size)
                self.view?.presentScene(scene, transition:reveal)
            }
            ]))
        
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}