//
//  GameScene.swift
//  foody
//
//  Created by Jonas Kucharz on 04/02/2016.
//  Copyright (c) 2016 Jonas Kucharz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let LEFT : UInt16 = 123
    let RIGHT : UInt16 = 124
    let DOWN : UInt16 = 125
    let UP : UInt16 = 126
    var score = 0
    let pug = SKSpriteNode(imageNamed: "pug_up.png")
    var wall = SKSpriteNode(imageNamed: "wall.png")
    var food = SKSpriteNode(imageNamed: "Bone.png")
    
    var move_left = SKAction.moveBy(CGVector(dx: -60, dy: 0), duration: 0.3)
    var move_right = SKAction.moveBy(CGVector(dx: 60, dy: 0), duration: 0.3)
    var move_down = SKAction.moveBy(CGVector(dx: 0, dy: -60), duration: 0.3)
    var move_up = SKAction.moveBy(CGVector(dx: 0, dy: 60), duration: 0.3)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Score = \(score)"
        myLabel.fontSize = 15
        myLabel.position = CGPoint(x: myLabel.frame.width, y: self.frame.height-30)
        self.addChild(myLabel)
        
        
        Swift.print(self.frame.size)
        pug.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        wall.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))

        
        self.addChild(pug)
        buildingWall()
        makeFood()
        pugLife()
    }
    
    override func keyDown(theEvent: NSEvent) {
        switch(theEvent.keyCode){
        case LEFT:
            //Swift.print("LEFT")
            pug.runAction(move_left)
            break
        case RIGHT:
            //Swift.print("RIGHT")
            //if !pug.hasActions()
            pug.runAction(move_right)
            break
        case DOWN:
            //Swift.print("DOWN")
            pug.runAction(move_down)
            break
        case UP:
            //Swift.print("UP")
            pug.runAction(move_up)
            break
        default:
            Swift.print("Autre")
        }
    }
    
    override func mouseDown(theEvent: NSEvent) {
        /* Called when a mouse click occurs */
        /*
        let location = theEvent.locationInNode(self)
        
        let sprite = SKSpriteNode(imageNamed:"Spaceship")
        sprite.position = location;
        sprite.setScale(0.5)
        
        let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        sprite.runAction(SKAction.repeatActionForever(action))
        
        self.addChild(sprite)
        */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func pugLife(){
        pug.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: pug.frame.width, height: pug.frame.height))
        pug.physicsBody?.allowsRotation = false
        pug.physicsBody?.affectedByGravity = false
        pug.physicsBody?.categoryBitMask = 2
        pug.physicsBody?.contactTestBitMask = 1
        pug.physicsBody?.collisionBitMask = 1

    }
    
    
    func buildingWall(){
        var pos = 16
        for var i = 0; i < 32; i++ {
            wall = SKSpriteNode(imageNamed: "wall.png")
            wall.position = CGPoint(x: pos, y: 16)
            self.addChild(wall)
            
            wall = SKSpriteNode(imageNamed: "wall.png")
            wall.position = CGPoint(x: pos, y: 752)
            self.addChild(wall)
            
            wall = SKSpriteNode(imageNamed: "wall.png")
            wall.position = CGPoint(x: 16, y: pos)
            self.addChild(wall)
            
            wall = SKSpriteNode(imageNamed: "wall.png")
            wall.position = CGPoint(x: 1008, y: pos)
            self.addChild(wall)
            pos += 32
        }
    }

    func makeFood(){
        food = SKSpriteNode(imageNamed: "Bone.png")
        food.setScale(CGFloat(0.25))
        food.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(food)
    }
}
