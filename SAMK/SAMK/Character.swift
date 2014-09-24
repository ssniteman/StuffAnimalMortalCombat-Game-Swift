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

    
    var body: SKSpriteNode!
    var direction: CGFloat = 1.0
    
    var textureNames: [String] = []
    
    init(animal:String) {
        
        var characterAtlas = SKTextureAtlas(named: animal)
    
        textureNames = sorted(characterAtlas.textureNames as [String], <)
        
        body = SKSpriteNode(imageNamed: characterAtlas.textureNames[0] as String)
        
        body.size = CGSizeMake(54, 116)
        
        body.physicsBody = SKPhysicsBody(rectangleOfSize: body.frame.size)
        
        
        
    }
    
    func moveRight() {
        direction = 1
        body.physicsBody?.applyImpulse(CGVectorMake(40.0, 0.0))
        
        var walkAction = SKAction.animateWithTextures(texturesFromNames(), timePerFrame: 0.1, resize: false, restore: true)
        
        body.runAction(walkAction)

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
        
        //        var kamehameha = NSKeyedUnarchiver.unarchiveObjectWithData(particlePath!) as SKEmitterNode
        
        //        var kamehameha = SKShapeNode(rectOfSize: CGSizeMake(100, 100), cornerRadius: 50)
        //        kamehameha.fillColor = UIColor.cyanColor()
        
        kamehameha.position = CGPointMake(body.position.x + 50 * direction, body.position.y)
        
        kamehameha.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        kamehameha.physicsBody?.affectedByGravity = false
        
        body.parent?.addChild(kamehameha)
        
        kamehameha.physicsBody?.applyImpulse(CGVectorMake(200.0 * direction, 0.0))
        
        body.physicsBody?.applyImpulse(CGVectorMake(-20.0 * direction, 0.0))
        
    }
    
    func texturesFromNames() -> [SKTexture] {
        
        var textures: [SKTexture] = []
        
        for textureName in textureNames {
            
            textures.append(SKTexture(imageNamed: textureName))
            
        }
        
        return textures
    }
    
    
}
