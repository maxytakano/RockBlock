//
//  ScoresScene.swift
//  SpriteKitSimpleGame
//
//  Created by Jason Wong on 10/16/14.
//  Copyright (c) 2014 Jason Wong. All rights reserved.
//

import SpriteKit

class ScoresScene: SKScene {
    var nameArray = ["Jason", "Humphrey", "Daniel", "Steven", "Justin", "Andrew", "Amy", "Elizabeth", "Brian", "Derek"]
    var scoreArray = ["97.0", "93.3", "92.1", "91.4", "89.2", "88.2", "82.2", "81.1", "80.2", "0.0"]
    
    override func didMoveToView(view: SKView) {
        var label:SKLabelNode
        
        var counter: CGFloat = 11
        
        nameArray.insert("Name", atIndex: 0)
        scoreArray.insert("Time", atIndex: 0)

        for names in nameArray {
            label = SKLabelNode(fontNamed: "Arial")
            label.fontSize = 20
            label.position = CGPoint(x: self.size.width/4, y: counter * self.size.height/12)
            label.text = names
         
            self.addChild(label)
            counter = counter - 1
        }
        
        counter = 11
        
        for scores in scoreArray {
            label = SKLabelNode(fontNamed: "Arial")
            label.fontSize = 20
            label.position = CGPoint(x: 3*self.size.width/4, y: counter * self.size.height/12)
            label.text = scores
            
            self.addChild(label)
            counter = counter - 1
        }
        
        
        /*
        let scrollView = UIScrollView()
        scrollView.sizeToFit()
        scrollView.hidden = true
        self.view?.addSubview(scrollView)
        scrollView.contentSize = self.calculateAccumulatedFrame().size
        self.view?.addGestureRecognizer(scrollView.panGestureRecognizer)*/

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let transition = SKTransition.fadeWithDuration(1)
        let scene = MenuScene(size: self.scene!.size)
        self.view?.presentScene(scene, transition: transition)
    }
}
