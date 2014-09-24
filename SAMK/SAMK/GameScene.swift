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
    
    var sun = SKSpriteNode(imageNamed: "sun")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = UIColor(red: 0.078, green: 0.827, blue: 0.949, alpha: 1.0)

        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.contactDelegate = self
        
        sun.size = CGSizeMake(SCREEN_HEIGHT, SCREEN_HEIGHT)
        sun.position = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
        
        self.addChild(sun)
        
        
        var bg = SKSpriteNode(imageNamed: "bg_front")
        bg.size = self.size
        bg.position = sun.position
        
        self.addChild(bg)
        
        var floor = SKShapeNode(rectOfSize: CGSizeMake(SCREEN_WIDTH, 10))
        floor.fillColor = UIColor.darkGrayColor()
        floor.position = CGPointMake(SCREEN_WIDTH / 2.0, 5)
        
        self.addChild(floor)
        
        
        floor.physicsBody = SKPhysicsBody(edgeLoopFromRect: floor.frame)
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.dynamic = false
        
        
        player1.body.position = CGPointMake(SCREEN_WIDTH / 2, 300)
        self.addChild(player1.body)
        
        player2.body.position = CGPointMake(SCREEN_WIDTH / 2, 300)
        self.addChild(player2.body)
        
        
        var floor1 = SKSpriteNode(imageNamed: "cloud")
        floor1.size = CGSizeMake(212, 55)
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
