//
//  Wall.swift
//  foody
//
//  Created by Jonas Kucharz on 21/02/2016.
//  Copyright © 2016 Jonas Kucharz. All rights reserved.
//

import Foundation
import SpriteKit

class Wall {
    
    var sprite : SKSpriteNode!
    
    init(name: String, spriteName: String, position: CGPoint, zPosition : CGFloat){
        let trapTexture = SKTexture(imageNamed: spriteName)
        self.sprite = SKSpriteNode(texture: trapTexture, size: CGSize(width:32,height:32))
        self.sprite.name = name
        self.sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.sprite.frame.width, height: self.sprite.frame.height))
        self.sprite.physicsBody!.dynamic = false
        self.sprite.physicsBody!.pinned = true
        self.sprite.physicsBody!.allowsRotation = false
        self.sprite.physicsBody!.affectedByGravity = false
        self.sprite.physicsBody!.categoryBitMask = GameScene.category.wall.rawValue | GameScene.category.tube.rawValue
        self.sprite.physicsBody!.collisionBitMask = GameScene.category.pug.rawValue
        self.sprite.position = position
        self.sprite.zPosition = zPosition
        
        if name == "tube" {
            self.sprite.physicsBody!.contactTestBitMask = GameScene.category.pug.rawValue
        }
    }
}
