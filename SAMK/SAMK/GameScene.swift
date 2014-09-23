//
//  GameScene.swift
//  SAMK
//
//  Created by Shane Sniteman on 9/22/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player1 = Character()
    var player2 = Character()
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.contactDelegate = self
        
//        self.physicsWorld.gravity = CGVectorMake(0.0, 1.0)
        
        
        var floor = SKShapeNode(rectOfSize: CGSizeMake(SCREEN_WIDTH, 10))
        floor.fillColor = UIColor.darkGrayColor()
        floor.position = CGPointMake(SCREEN_WIDTH / 2.0, 5)
        self.addChild(floor)
        
        
        floor.physicsBody = SKPhysicsBody(edgeLoopFromRect: floor.frame)
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.dynamic = false
        
        
        player1.body.position = CGPointMake(300, 300)
        self.addChild(player1.body)
        
        var floor1 = SKShapeNode(rectOfSize: CGSizeMake(200, 10))
        floor1.fillColor = UIColor.darkGrayColor()
        floor1.position = CGPointMake(SCREEN_WIDTH / 2.0, 120)
        
        
        floor1.physicsBody = SKPhysicsBody(edgeLoopFromRect: floor1.frame)
        floor1.physicsBody?.affectedByGravity = false
        floor1.physicsBody?.dynamic = false
        
        
        self.addChild(floor1)

    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
