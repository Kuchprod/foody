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
        
        self.move()

    }
    
    private func move(){
        var numMove : Int = 0
        var i : Int = 0
        var tabAction : [SKAction] = []
        var action : SKAction = move_down
        
        for i = 0; i < 50; i++ {
            numMove = Int(arc4random_uniform(4))
            if numMove % 4 == 0 {
                action = move_left
            }
            else if numMove % 4 == 1 {
                action = move_right
            }
            else if numMove % 4 == 2 {
                action = move_up
            }
            else if numMove % 4 == 3 {
                action = move_down
            }
            tabAction += [action]
        }
        self.sprite.runAction(SKAction.repeatActionForever(SKAction.sequence(tabAction)))
        /*
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
*/
        
    }
    
}