//
//  Character.swift
//  SAMK
//
//  Created by Shane Sniteman on 9/22/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

import UIKit
import SpriteKit

class Character: NSObject {
 
    // We had a character class, but nothing set to it

    
    var body: SKShapeNode!
    
    override init() {
        
        super.init()
        
        body = SKShapeNode(rectOfSize: CGSizeMake(40, 70))
        body.fillColor = UIColor.redColor()
        body.physicsBody = SKPhysicsBody(rectangleOfSize: body.frame.size)
        
    }
    
    
}
