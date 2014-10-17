//
//  MenuScene.swift
//  SpriteKitSimpleGame
//
//  Created by Jason Wong on 10/16/14.
//  Copyright (c) 2014 Jason Wong. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "background.png")
    let _playButton: SKSpriteNode = SKSpriteNode(imageNamed: "play.png")
    let _playButtonPressed: SKSpriteNode = SKSpriteNode(imageNamed: "play-pressed.png")
    let _menuButton: SKSpriteNode = SKSpriteNode(imageNamed: "scores.png")
    let _menuButtonPressed: SKSpriteNode = SKSpriteNode(imageNamed: "scores-pressed.png")
    //var firstTouched = "none"
    
    override func didMoveToView(view: SKView) {
        
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.size = self.size
        background.zPosition = -2
        self.addChild(background)
        
        // Add pressed play button and set it to hidden
        _playButtonPressed.position = CGPoint(x: self.size.width/3 , y: self.size.height/2)
        _playButtonPressed.setScale(0.5)
        self.addChild(_playButtonPressed)
        _playButtonPressed.hidden = true
        
        // Add pressed menu button and set it to hidden
        _menuButtonPressed.position = CGPoint(x: 2*self.size.width/3, y: self.size.height/2)
        _menuButtonPressed.setScale(0.5)
        self.addChild(_menuButtonPressed)
        _menuButtonPressed.hidden = true

        // Add unpressed play button and display
        _playButton.position = CGPoint(x: self.size.width/3 , y:self.size.height/2)
        _playButton.setScale(0.5)
        self.addChild(_playButton)
        
        // Add unpressed menu button and display
        _menuButton.position = CGPoint(x: 2*self.size.width/3, y: self.size.height/2)
        _menuButton.setScale(0.5)
        self.addChild(_menuButton)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        println("touch")
        for touch: AnyObject in touches {
            if CGRectContainsPoint(_playButton.frame, touch.locationInNode(self)) {
                _playButton.hidden = true
                _playButtonPressed.hidden = false
                //firstTouched = "play"
            }
            if CGRectContainsPoint(_menuButton.frame, touch.locationInNode(self)) {
                _menuButton.hidden = true
                _menuButtonPressed.hidden = false
                //firstTouched = "menu"
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        println("touchesEnded")
        for touch: AnyObject in touches {
            if CGRectContainsPoint(_playButton.frame, touch.locationInNode(self))  {
                let transition = SKTransition.fadeWithDuration(1)
                let scene = GameScene(size: self.scene!.size)
                self.view?.presentScene(scene, transition: transition)
            }
            if CGRectContainsPoint(_menuButton.frame, touch.locationInNode(self)) {
                let transition = SKTransition.fadeWithDuration(1)
                let scene = ScoresScene(size: self.scene!.size)
                self.view?.presentScene(scene, transition: transition)
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        println("moved")
        for touch: AnyObject in touches {
            if CGRectContainsPoint(_playButton.frame, touch.locationInNode(self)) {
                _playButton.hidden = false
                _playButtonPressed.hidden = true
            }
            if CGRectContainsPoint(_menuButton.frame, touch.locationInNode(self)) {
                _menuButton.hidden = false
                _menuButtonPressed.hidden = true
            }
        }
    }
    
    
    override func touchesCancelled(touches: NSSet, withEvent event: UIEvent) {
        println("yo")
    }
}
