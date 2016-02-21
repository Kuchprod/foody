//
//  Food.swift
//  foody
//
//  Created by Jonas Kucharz on 21/02/2016.
//  Copyright © 2016 Jonas Kucharz. All rights reserved.
//

import Foundation
import SpriteKit

class Food {
    
    var sprite : SKSpriteNode!
    
    init(name : String, spriteName: String, position: CGPoint){
        let trapTexture = SKTexture(imageNamed: "bone")
        self.sprite = SKSpriteNode(texture: trapTexture, size: CGSize(width:32,height:32))
        self.sprite.name = "bone"
        self.sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.sprite.frame.width-2, height: self.sprite.frame.height-2))
        self.sprite.physicsBody!.dynamic = false
        self.sprite.physicsBody!.allowsRotation = false
        self.sprite.physicsBody!.affectedByGravity = false
        self.sprite.physicsBody!.categoryBitMask = GameScene.category.bone.rawValue
        self.sprite.physicsBody!.contactTestBitMask = GameScene.category.pug.rawValue
        self.sprite.physicsBody!.collisionBitMask = 0
        self.sprite.lightingBitMask = GameScene.category.light.rawValue
        self.sprite.position = position
    }
}