//
//  ParticleSystem.swift
//  spritekitTest190
//
//  Created by Max Takano on 10/15/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//

import Foundation
import SpriteKit

// Probably will want to pass in the image type of wanted particle
func newExplosion() -> SKEmitterNode {
    let explosion = SKEmitterNode()
    
    //explosion.particleTexture =
    explosion.particleTexture = SKTexture(imageNamed: "Kakuna")
    explosion.particleColor = UIColor.redColor()
    explosion.numParticlesToEmit = 100
    explosion.particleBirthRate = 450
    explosion.particleLifetime = 2
    explosion.emissionAngleRange = 360
    explosion.particleSpeed = 100
    explosion.particleSpeedRange = 50
    explosion.xAcceleration = 0
    explosion.yAcceleration = 0
    explosion.particleAlpha = 1.0
    explosion.particleAlphaRange = 0.0
    explosion.particleAlphaSpeed = 0.0
    explosion.particleScale = 0.75
    explosion.particleScaleRange = 0.4
    explosion.particleScaleSpeed = -0.5
    explosion.particleRotation = 0
    explosion.particleRotationRange = 0
    explosion.particleRotationSpeed = 0
    
    explosion.particleColorBlendFactor = 0.0
    explosion.particleColorBlendFactorRange = 0
    explosion.particleColorBlendFactorSpeed = 0
    explosion.particleBlendMode = SKBlendMode.Add
    
    return explosion
}