//
//  GameScene.swift
//  spritekitTest190
//
//  Created by Max Takano on 10/14/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//

import SpriteKit

struct PhysicsCategory {
    static let None      : UInt32 = 0
    static let All       : UInt32 = UInt32.max
    static let Player    : UInt32 = 0b1       // 1
    static let Projectile: UInt32 = 0b10      // 2
}


class GameScene: SKScene, SKPhysicsContactDelegate {

    // 1
    let player = SKSpriteNode(imageNamed: "Kakuna")
    let staminaBar = SKSpriteNode()
    
    // Initialize playerStamina and state
    let maxPlayerStamina = 100.0
    var maxStaminaBarHeight = CGFloat()       // init below
    var playerStamina = Double()
    var playerIsHard = false
    
    // Initialize time holders
    var minutes = 0
    var seconds = 0

    override func didMoveToView(view: SKView) {
        endGame()
        
        // initialize high score for first run
        if (NSUserDefaults.standardUserDefaults().objectForKey("HighScore") == nil) {
            println("first Score")
            var firstScore:[Int] = [0, 0]
            
            NSUserDefaults.standardUserDefaults().setObject(firstScore as NSArray, forKey:"HighScore")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
        // Initialize High Score Label
        var currentHighScore = NSUserDefaults.standardUserDefaults().objectForKey("HighScore") as NSArray

        var highScoreLabel = SKLabelNode()
        highScoreLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        highScoreLabel.fontColor = UIColor.blackColor()
        highScoreLabel.fontSize = 18
        highScoreLabel.fontName = "Chalkduster"
        highScoreLabel.text = "Time to beat \(currentHighScore[0]):\(currentHighScore[1])"
        addChild(highScoreLabel)
        
        // Initialize score timer
        var scoreLabel = SKLabelNode()
        scoreLabel.position = CGPoint(x: size.width * 0.5, y: size.height * 0.95)
        scoreLabel.fontColor = UIColor.blackColor()
        scoreLabel.fontSize = 18
        scoreLabel.fontName = "Chalkduster"
        scoreLabel.text = "Time Lasted: \(self.minutes/60):\(self.seconds)"
        
        addChild(scoreLabel)
        
        var actionwait = SKAction.waitForDuration(1.0)
        var actionrun = SKAction.runBlock({
            self.minutes++
            self.seconds++
            if self.seconds == 60 {self.seconds = 0}
            scoreLabel.text = "TimeLasted: \(self.minutes/60):\(self.seconds)"
        })
        scoreLabel.runAction(SKAction.repeatActionForever(SKAction.sequence([actionwait,actionrun])))
        
        
        // Initialize up long press gesture
        let recognizer = UILongPressGestureRecognizer(target: self, action: Selector("handleTap:"))
        recognizer.minimumPressDuration = 0.0;
        recognizer.cancelsTouchesInView = false;
        recognizer.delaysTouchesEnded = false
        
        view.addGestureRecognizer(recognizer)
        
        //640 x 960 resolution
        
        // 2
        //backgroundColor = SKColor.whiteColor()
        
        // set up background image
        let backgroundImage = SKSpriteNode(imageNamed: "tree")
        
        // Set the position to the middle of the screen
        backgroundImage.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        // make the background sprite be in the very back
        backgroundImage.zPosition = -10
        
        // add as a child to the view
        addChild(backgroundImage)
        
        // 3
        player.position = CGPoint(x: size.width * 0.5, y: size.height * 0.2)
        
        // Set up player physics
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.height/2) // 1
        player.physicsBody?.dynamic = true // 2
        player.physicsBody?.categoryBitMask = PhysicsCategory.Player // 3
        player.physicsBody?.contactTestBitMask = PhysicsCategory.Projectile // 4
        player.physicsBody?.collisionBitMask = PhysicsCategory.None // 5
        
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
        // Debug to show physics boundries
        //view.showsPhysics = true
        
        
        // Initialize Player
        
        // Initialize harden color
        player.color = SKColor.redColor()
    
        addChild(player)
        
        
        // initialize stamina bar
        staminaBar.color = UIColor.greenColor()
        staminaBar.size = CGSize(width: size.width * 0.07, height: size.height * 0.8)
        staminaBar.position = CGPoint(x: size.width * 0.9, y: size.height * 0.1)
        staminaBar.anchorPoint = CGPointMake(0.0, 0.0)
        
        addChild(staminaBar)
        
        // init player stamina
        playerStamina = maxPlayerStamina
        maxStaminaBarHeight = staminaBar.size.height
        
        
        
        runAction(SKAction.repeatActionForever(
            SKAction.sequence([
                SKAction.runBlock(addRock),
                SKAction.waitForDuration(0.9, withRange: 2.0)
                ])
            ))
    }
    
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        //self.chompPlayer?.play()
        
        player.color = SKColor.redColor()
        
        // Pass in the press state to update the player
        // 1 == pressed down, 3 == released
        updatePlayerState(recognizer.state.toRaw())
        
    }
    
    func updatePlayerState(currentState: Int) {
        if (currentState == 1) {
            playerIsHard = true
            
            // allow the red to show
            player.colorBlendFactor = 1.0
            
            var drainAction = SKAction.repeatActionForever(
                SKAction.sequence([
                    SKAction.runBlock(drainStamina),
                    SKAction.waitForDuration(0.1)
                    ])
            )
            runAction(drainAction, withKey: "drainAction1")
        }
        else if (currentState == 3) {
            playerIsHard = false
            
            // return to normal color
            player.colorBlendFactor = 0.0
            removeActionForKey("drainAction1")
            
        }
    }
    
    func drainStamina() {
        playerStamina -= 0.95
        var ratio = playerStamina / maxPlayerStamina
        staminaBar.size.height = maxStaminaBarHeight * CGFloat(ratio)
        
        // Todo: put below code in a func and call here and when hit by rock
        if (playerStamina < 0) {
            endGame()
        }
    }
    
    
    func addRock() {
    
        // Create sprite
        let rock = SKSpriteNode(imageNamed: "projectile")
        
        // Set up physics
        rock.physicsBody = SKPhysicsBody(circleOfRadius: rock.size.height/2.3) // 1
        rock.physicsBody?.dynamic = true // 2
        rock.physicsBody?.categoryBitMask = PhysicsCategory.Projectile // 3
        rock.physicsBody?.contactTestBitMask = PhysicsCategory.Player // 4
        rock.physicsBody?.collisionBitMask = PhysicsCategory.None // 5
        rock.physicsBody?.usesPreciseCollisionDetection = true
        
        // Determine where to spawn the rock along the X axis
        //let actualX = random(min: rock.size.width/2, max: size.width - rock.size.width/2)
        let actualX = size.width/2;
        
        // Position the rock slightly above the top edge,
        // and along a random position along the X axis as calculated above
        rock.position = CGPoint(x: actualX, y:size.height + rock.size.height/2)
        
        // Add the rock to the scene
        addChild(rock)
        
        // Determine speed of the rock
        let actualDuration = getRandom(min: 2.0, 4.0)
        //let actualDuration = CGFloat(3.0);
        
        // Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: actualX, y: -rock.size.height/2), duration: NSTimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        
        /*let loseAction = SKAction.runBlock() {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let gameOverScene = GameOverScene(size: self.size, won: false)
            self.view?.presentScene(gameOverScene, transition: reveal)
        }*/
        //rock.runAction(SKAction.sequence([actionMove, loseAction, actionMoveDone]))
        
        rock.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        // Determine which order to collide the bodies in
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        // Order the contact of the bodies
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // check if the bodies are a player and projecile, 
        // if yes trigger rockDidCollideWithPlayer
        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)) {
                rockDidCollideWithPlayer(firstBody.node as SKSpriteNode, rock: secondBody.node as SKSpriteNode)
        }
        
    }
    
    
    func rockDidCollideWithPlayer(player:SKSpriteNode, rock:SKSpriteNode) {
        if (playerIsHard) {
            // Debug
            //println("blocked the rock")
            
            // blow the rock up with particle systems
            let explosion = newExplosion()
            explosion.position = rock.position
            addChild(explosion)
        } else {
            // Debug
            //println("Player hit")
            
            // Show that the player was damaged by blinking
            let blinkAction = SKAction.sequence([SKAction.fadeOutWithDuration(0.1), SKAction.fadeInWithDuration(0.1)])
            let blinkForTime = SKAction.repeatAction(blinkAction, count: 3)
            player.runAction(SKAction.sequence([blinkForTime]))
            
            // lower player health
            playerStamina -= 34
            var ratio = playerStamina / maxPlayerStamina
            staminaBar.size.height = maxStaminaBarHeight * CGFloat(ratio)
            
            if (playerStamina < 0) {
                endGame()
            }
            
            // maybe set player to invuln while blinking
            
        }
        
        // Remove rock from view
        rock.removeFromParent()
        
        /*rocksDestroyed++
        if (rocksDestroyed > 8) {
        let reveal = SKTransition.flipHorizontalWithDuration(0.5)
        let gameOverScene = GameOverScene(size: self.size, won: true)
        self.view?.presentScene(gameOverScene, transition: reveal)
        }*/
    }
    
    
    func endGame() {
        
        var score:[Int] = [minutes/60, seconds]
    
        // get the current high score
        var currentHighScore = NSUserDefaults.standardUserDefaults().objectForKey("HighScore") as NSArray
        
        // Type cast to Int
        var oldMinutes = currentHighScore[0] as Int
        var oldSeconds = currentHighScore[1] as Int
        
        println("Score to beat \(oldMinutes) \(oldSeconds)")
        
        if (score[0] * 60 + score[1] > oldMinutes * 60 + oldSeconds) {
            // Beat best time
            println("beat time")
            
            // Save high score
            // Score must be typcasted as an NSArray to work with UserDefaults
            NSUserDefaults.standardUserDefaults().setObject(score as NSArray, forKey:"HighScore")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            // switch to win screen
            let winAction = SKAction.runBlock() {
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let gameOverScene = GameOverScene(size: self.size,
                    won: true,
                    seconds:self.seconds,
                    minutes:self.minutes)
                self.view?.presentScene(gameOverScene, transition: reveal)
            }
            runAction(winAction)
        } else {
            // You lose
            let loseAction = SKAction.runBlock() {
                let reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let gameOverScene = GameOverScene(size: self.size,
                    won: false,
                    seconds:self.seconds,
                    minutes:self.minutes)
                self.view?.presentScene(gameOverScene, transition: reveal)
            }
            runAction(loseAction)
        }

        
    }
    
    
}






