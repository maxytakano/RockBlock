//
//  CustomProgressBar.swift
//  spritekitTest190
//
//  Created by Max Takano on 10/15/14.
//  Copyright (c) 2014 Max Takano. All rights reserved.
//

import Foundation
import SpriteKit



//DEPRICATED
// Just using a sprite node insetead
class CustomProgressBar : SKCropNode {
    
    var progressBar: SKSpriteNode
    
    override init() {
        progressBar = SKSpriteNode(color: UIColor.greenColor(),
            size: CGSize(width: 10, height: 10))
        super.init()
    }
    
    init(view: SKView) {
        progressBar = SKSpriteNode(color: UIColor.greenColor(),
            size: CGSize(width: 10, height: 10))
        
        super.init()
        
        
        maskNode = SKSpriteNode(color: UIColor.whiteColor(),
                                size: CGSize(width: 10,height: 10))

        addChild(progressBar)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSpriteSize (screenSize: CGSize) {
        progressBar.size = CGSize(width: screenSize.width * 0.07, height: screenSize.height * 0.8)
        maskNode = SKSpriteNode(color: UIColor.whiteColor(),
                                size: CGSize(width: screenSize.width * 0.07, height: screenSize.height * 0.8))
        
    }
    
    func setProgress(progress:CGFloat) {
        maskNode?.yScale = progress
    }

}