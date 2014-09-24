//
//  Character.swift
//  SAMK
//
//  Created by Shane Sniteman on 9/22/14.
//  Copyright (c) 2014 Shane Sniteman. All rights reserved.
//

import UIKit
import SpriteKit

let FIRE_CONTACT: UInt32 = 10
let PLAYER_CONTACT: UInt32 = 2
let MAX_HP: Int = 100


class Character: NSObject {
 
    // We had a character class, but nothing set to it

    
    var body: SKSpriteNode!
    var direction: CGFloat = 1.0
    
    var currentHP: Int = 100
    var textureNames: [String] = []
    
    init(animal:String) {
        
        var characterAtlas = SKTextureAtlas(named: animal)
        textureNames = sorted(characterAtlas.textureNames as [String], <)
        body = SKSpriteNode(imageNamed: characterAtlas.textureNames[0] as String)
        body.size = CGSizeMake(54, 116)
        body.physicsBody = SKPhysicsBody(rectangleOfSize: body.frame.size)
        body.physicsBody?.allowsRotation = false
        body.physicsBody?.categoryBitMask = FIRE_CONTACT
        
    }
    
    func moveRight() {
        direction = 1
        body.physicsBody?.applyImpulse(CGVectorMake(40.0, 0.0))
        
        var walkAction = SKAction.animateWithTextures(texturesFromNames(), timePerFrame: 0.1, resize: false, restore: true)
        
        body.runAction(walkAction)
        body.xScale = direction


    }
    
    func moveLeft() {
        direction = -1
        body.physicsBody?.applyImpulse(CGVectorMake(-40.0, 0.0))
        
        var walkAction = SKAction.animateWithTextures(texturesFromNames(), timePerFrame: 0.1, resize: false, restore: true)
        
        body.runAction(walkAction)
        body.xScale = direction

    }
    
    func jump() {
        body.physicsBody?.applyImpulse(CGVectorMake(0.0, 50.0))
    }
    
    func fire() {
        
        var particlePath = NSBundle.mainBundle().pathForResource("MyParticle", ofType: "sks")
        
        var sceneData = NSData.dataWithContentsOfFile(particlePath!, options: .DataReadingMappedIfSafe, error: nil)
        
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(SKEmitterNode.self, forClassName: "SKEditorScene")
        let node = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as SKEmitterNode?
        archiver.finishDecoding()
        
        var kamehameha = node!
        
        kamehameha.position = CGPointMake(body.position.x + 50 * direction, body.position.y)
        
        kamehameha.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        kamehameha.physicsBody?.affectedByGravity = false
        
        body.parent?.addChild(kamehameha)
        
        kamehameha.physicsBody?.applyImpulse(CGVectorMake(10.0 * direction, 0.0))
        
        body.physicsBody?.applyImpulse(CGVectorMake(-5.0 * direction, 0.0))
        
        // Trying to get contact to happen
        
        kamehameha.physicsBody?.contactTestBitMask = FIRE_CONTACT
//        kamehameha.physicsBody?.collisionBitMask = FIRE_CONTACT

    }
    
    func texturesFromNames() -> [SKTexture] {
        
        var textures: [SKTexture] = []
        
        for textureName in textureNames {
            
            textures.append(SKTexture(imageNamed: textureName))
            
        }
        
        return textures
    }
    
    func checkHit (bodyA:SKPhysicsBody, bodyB: SKPhysicsBody) {
        
        if bodyA.node == self {
            
            currentHP -= 10
            bodyB.node?.removeFromParent()
            
            NSNotificationCenter.defaultCenter().postNotificationName("healthUpdate", object: nil, userInfo: ["player":self])
        }
        
    }
    
    
}
