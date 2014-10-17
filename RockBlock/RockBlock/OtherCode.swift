//
//  OtherCode.swift
//  spritekitTest190
//
//  Created by Max Takano on 10/15/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//

import Foundation

// OLD: update method
/*override func update(currentTime: CFTimeInterval) {
/* Called before each frame is rendered */
//println(rock.position);
}*/


// OLD: touch stuff
/*override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {

// 1 - Choose one of the touches to work with
let touch = touches.anyObject() as UITouch
let touchLocation = touch.locationInNode(self)

// 2 - Set up initial location of projectile
/*let projectile = SKSpriteNode(imageNamed: "projectile")
projectile.position = player.position

projectile.physicsBody = SKPhysicsBody(circleOfRadius: projectile.size.width/2)
projectile.physicsBody?.dynamic = true
projectile.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
projectile.physicsBody?.contactTestBitMask = PhysicsCategory.rock
projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
projectile.physicsBody?.usesPreciseCollisionDetection = true

// 3 - Determine offset of location to projectile
let offset = touchLocation - projectile.position

// 4 - Bail out if you are shooting down
if (offset.y < 0) { return }

// 5 - OK to add now - you've double checked position
addChild(projectile)

// 6 - Get the direction of where to shoot
let direction = offset.normalized()

// 7 - Make it shoot far enough to be guaranteed off screen
let shootAmount = direction * 1000

// 8 - Add the shoot amount to the current position
let realDest = shootAmount + projectile.position

// 9 - Create the actions
let actionMove = SKAction.moveTo(realDest, duration: 2.0)
let actionMoveDone = SKAction.removeFromParent()
projectile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
*/

}*/