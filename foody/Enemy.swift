//
//  Enemy.swift
//  foody
//
//  Created by Jonas Kucharz on 21/02/2016.
//  Copyright © 2016 Jonas Kucharz. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy {
    
    var sprite : SKSpriteNode!
    var num : Int = 0
    
    let move_left = SKAction.moveBy(CGVector(dx: -32, dy: 0), duration: 1)
    let move_right = SKAction.moveBy(CGVector(dx: 32, dy: 0), duration: 1)
    let move_down = SKAction.moveBy(CGVector(dx: 0, dy: -32), duration: 1)
    let move_up = SKAction.moveBy(CGVector(dx: 0, dy: 32), duration: 1)
    

    
    init(name: String, spriteName: String, position: CGPoint, num : Int){
        self.num = num
        let trapTexture = SKTexture(imageNamed: spriteName)
        self.sprite = SKSpriteNode(texture: trapTexture, size: CGSize(width:32,height:32))
        self.sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.sprite.frame.width-2, height: self.sprite.frame.height-2))
        self.sprite.name = name
        self.sprite.physicsBody!.dynamic = true
        self.sprite.physicsBody!.allowsRotation = false
        self.sprite.physicsBody!.affectedByGravity = false
        self.sprite.physicsBody!.categoryBitMask = GameScene.category.trap.rawValue
        self.sprite.physicsBody!.collisionBitMask = GameScene.category.wall.rawValue
        self.sprite.physicsBody!.contactTestBitMask = GameScene.category.pug.rawValue | GameScene.category.wall.rawValue
        self.sprite.lightingBitMask = GameScene.category.light.rawValue
        self.sprite.position = position
        self.sprite.zPosition = 1
        move()
    }
    
    private func move(){
        let seq1 = SKAction.sequence([move_left, move_down, move_right, move_up])
        let seq2 = SKAction.sequence([move_down, move_right, move_up, move_left])
        let seq3 = SKAction.sequence([move_right, move_up, move_left, move_down])
        let seq4 = SKAction.sequence([move_up, move_left, move_down, move_right])
        
        if self.num % 4 == 0 {
            self.sprite.runAction(SKAction.repeatActionForever(seq1))
        }
        else if self.num % 4 == 1 {
            self.sprite.runAction(SKAction.repeatActionForever(seq2))
        }
        else if self.num % 4 == 2 {
            self.sprite.runAction(SKAction.repeatActionForever(seq3))
        }
        else if self.num % 4 == 3 {
            self.sprite.runAction(SKAction.repeatActionForever(seq4))
        }
        
    }
    
}