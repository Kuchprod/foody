//
//  User.swift
//  foody
//
//  Created by Jonas Kucharz on 16/02/2016.
//  Copyright © 2016 Jonas Kucharz. All rights reserved.
//

import Foundation
import SpriteKit

class User {
    
    var nameUser : String = ""
    var score : Int = 0
    var scoreByLevel : Int = 0
    var life : Int = 100
    var level : Int = 1
    
    var sprite : SKSpriteNode!
    var light : SKLightNode!
    var tubeLight : SKLightNode!
    
    init(name: String,  score: Int, life : Int, spriteName: String){
        self.nameUser = name
        self.score = score
        self.life = life
        let trapTexture = SKTexture(imageNamed: spriteName)
        self.sprite = SKSpriteNode(texture: trapTexture, size: CGSize(width:32,height:32))
        self.sprite.name = name
        self.sprite.position = CGPoint(x: 48, y: 48)
        self.sprite.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width:30,height:30))
        self.sprite.physicsBody?.dynamic = true
        self.sprite.physicsBody?.allowsRotation = false
        self.sprite.physicsBody?.affectedByGravity = false
        self.sprite.physicsBody?.categoryBitMask = GameScene.category.pug.rawValue
        self.sprite.physicsBody?.contactTestBitMask = GameScene.category.tube.rawValue | GameScene.category.bone.rawValue | GameScene.category.trap.rawValue
        self.sprite.physicsBody?.collisionBitMask = GameScene.category.wall.rawValue
        
        configLight()
        configTubeLight()
    }
    
    func configLight(){
        self.light = SKLightNode()
        self.light.name = "light"
        self.light.falloff = 2.5
        self.light.categoryBitMask = GameScene.category.light.rawValue
        self.light.position = CGPointMake(0,0)
        self.light.lightColor = NSColor.whiteColor()
        //self.light.shadowColor = NSColor.redColor()
        self.light.ambientColor = NSColor.blackColor()
        self.light.zPosition = 1
        self.sprite.addChild(self.light)
    }
    
    func configTubeLight(){
        self.tubeLight = SKLightNode()
        self.tubeLight.name = "tubeLight"
        self.tubeLight.falloff = 4
        self.tubeLight.categoryBitMask = GameScene.category.tube_light.rawValue
        self.tubeLight.position = CGPointMake(0,0)
        self.tubeLight.lightColor = NSColor.redColor()
        self.tubeLight.zPosition = 1
        self.sprite.addChild(self.tubeLight)
    }
}

