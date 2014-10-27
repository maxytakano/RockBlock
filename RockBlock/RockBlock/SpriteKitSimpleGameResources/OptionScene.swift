//
//  OptionScene.swift
//  RockBlock
//
//  Created by Jason Wong on 10/18/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    let background = SKSpriteNode(imageNamed: "background.png")
    var userDefaults = NSUserDefaults.standardUserDefaults()
    let musicSwitch = SevenSwitch()
    let soundSwitch = SevenSwitch()
    let _menuButton: SKSpriteNode = SKSpriteNode(imageNamed: "scores.png")
    let _menuButtonPressed: SKSpriteNode = SKSpriteNode(imageNamed: "scores-pressed.png")

    override func didMoveToView(view: SKView) {
        // Add background to the view
        background.anchorPoint = CGPoint(x: 0, y: 0)
        background.size = self.size
        background.zPosition = -2
        self.addChild(background)
        
        // Add menu button and set it to hidden
        _menuButtonPressed.position = CGPoint(x: self.size.width/2, y:self.size.height*0.1)
        _menuButtonPressed.setScale(0.5)
        self.addChild(_menuButtonPressed)
        _menuButtonPressed.hidden = true
        _menuButton.position = CGPoint(x: self.size.width/2 , y:self.size.height*0.1)
        _menuButton.setScale(0.5)
        self.addChild(_menuButton)
        
        
        // Create switches and add to view
        runAction(SKAction.sequence([
            SKAction.waitForDuration(0),
            SKAction.runBlock() {
                self.view?.addSubview(self.musicSwitch)
                self.view?.addSubview(self.soundSwitch)
                // anchorPoint
            }
            ])
        )
        
        
        musicSwitch.center = CGPoint(x: self.size.width*0.75,  y: self.size.height*0.5)
        soundSwitch.center = CGPoint(x: self.size.width*0.25, y: self.size.height*0.5)
        
        // Associate events for when the switches are changed
        musicSwitch.addTarget(self, action: "musicWasSwitched:", forControlEvents: UIControlEvents.ValueChanged)
        soundSwitch.addTarget(self, action: "soundWasSwitched:", forControlEvents: UIControlEvents.ValueChanged)
        
        // Add labels to the switches
        let musicLabel = SKLabelNode(fontNamed: "Arial")
        musicLabel.fontSize = 20
        musicLabel.position = CGPoint(x: self.size.width*0.75, y:  self.size.height*0.55)
        musicLabel.text = "Music"
        self.addChild(musicLabel)
        
        let soundLabel = SKLabelNode(fontNamed: "Arial")
        soundLabel.fontSize = 20
        soundLabel.position = CGPoint(x: self.size.width*0.25, y:  self.size.height*0.55)
        soundLabel.text = "Sound"
        self.addChild(soundLabel)
        
        // Get defaults from app data
        if let soundIsOn = userDefaults.valueForKey("sound") as? Int{
            if(soundIsOn == 1) {
                soundSwitch.setOn(true, animated: false)
                
                if let musicIsOn = userDefaults.valueForKey("music") as? Int {
                    if(musicIsOn == 1) {
                        musicSwitch.setOn(true, animated: false)
                    }
                    else {
                        musicSwitch.setOn(false, animated: false)
                    }
                }
            }
            else {
                soundSwitch.setOn(false, animated: false)
                musicSwitch.setOn(false, animated: false)
            }
        }
        else {
            musicSwitch.setOn(true, animated: true)
            soundSwitch.setOn(true, animated: true)
        }
    }
    
    // Function for when music switch changes
    func musicWasSwitched(sender: SevenSwitch) {
        saveSwitchResults("music", offOrOn: sender.on)
    }
    
    // Function for when sound switch changes
    func soundWasSwitched(sender: SevenSwitch) {
        saveSwitchResults("sound", offOrOn: sender.on)

    }
    
    // Function to save the current state of the for states as default
    func saveSwitchResults(switchName: String, offOrOn: Bool) {
        if switchName == "music" {
            if musicSwitch.on == true {
                soundSwitch.setOn(true, animated:true)
            }
        }
        else if( switchName == "sound") {
            if soundSwitch.on == false {
                if(musicSwitch.on == true) {
                    musicSwitch.setOn(false, animated: true)
                }
            }
        }
        userDefaults.setValue(musicSwitch.on, forKey: "music")
        userDefaults.setValue(soundSwitch.on, forKey: "sound")
        userDefaults.synchronize()
    }
    
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            if CGRectContainsPoint(_menuButton.frame, touch.locationInNode(self))  {

                let transition = SKTransition.fadeWithDuration(1)
                let scene = MenuScene(size: self.scene!.size)
                self.view?.presentScene(scene, transition: transition)
                musicSwitch.removeFromSuperview()
                soundSwitch.removeFromSuperview()
                
            }
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            if CGRectContainsPoint(_menuButton.frame, touch.locationInNode(self)) {
                _menuButton.hidden = true
                _menuButtonPressed.hidden = false
            }
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        println("moved")
        for touch: AnyObject in touches {
            if CGRectContainsPoint(_menuButton.frame, touch.locationInNode(self)) {
                _menuButton.hidden = false
                _menuButtonPressed.hidden = true
            }
        }
    }

}


