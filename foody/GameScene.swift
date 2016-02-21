//
//  GameScene.swift
//  foody
//
//  Created by Jonas Kucharz on 04/02/2016.
//  Copyright (c) 2016 Jonas Kucharz. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    enum direction:UInt16{
        case LEFT = 123
        case RIGHT = 124
        case DOWN = 125
        case UP = 126
    }
    
    enum category:UInt32{
        case wall = 1
        case pug = 2
        case bone = 4
        case tube = 8
        case trap = 16
        case light = 32
        case tube_light = 64
    }
    
    var nbBone: Int = 7
    var nbTrap: Int = 5
    var nbWall: Int = 32

    var lab_score = SKLabelNode(fontNamed:"Chalkduster")
    var lab_life = SKLabelNode(fontNamed:"Chalkduster")
    var lab_level = SKLabelNode(fontNamed:"Chalkduster")
    
    var user : User = User(name: "pug", score: 0, life: 100, spriteName: "pug_up.png")
    var wall : SKSpriteNode! = nil
    var bone : SKSpriteNode! = nil
    var tube : SKSpriteNode! = nil
    var trap : SKSpriteNode! = nil
    
    
    
    var move_left = SKAction.moveBy(CGVector(dx: -32, dy: 0), duration: 0.02)
    var move_right = SKAction.moveBy(CGVector(dx: 32, dy: 0), duration: 0.02)
    var move_down = SKAction.moveBy(CGVector(dx: 0, dy: -32), duration: 0.02)
    var move_up = SKAction.moveBy(CGVector(dx: 0, dy: 32), duration: 0.02)
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self
        
        self.addChild(user.sprite)
        information()
        buildingWall()
        createBackground()
        makeElement()
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        //Swift.print("A = \(contact.bodyA.node?.name)")
        //Swift.print("B = \(contact.bodyB.node?.name)")
        if(contact.bodyB.node?.name == "bone"){
            contact.bodyB.node?.removeFromParent()
            self.user.score++
            self.user.scoreByLevel++
        }
        
        if(contact.bodyB.node?.name == "trap"){
            self.user.life -= 20
            contact.bodyB.node?.removeFromParent()
        }
        
        if(contact.bodyA.node?.name == "tube" || contact.bodyB.node?.name == "tube"){
            nextScene(0.8, finish: false)
        }
        self.lab_life.text = "Life = \(self.user.life)"
        self.lab_score.text = "Score = \(self.user.score)"
        if(self.user.life == 0){
            let trans = SKTransition.fadeWithColor(NSColor.redColor(), duration: 2)
            let scene = GameOver(fileNamed:"GameOver")
            scene!.scaleMode = .Fill
            self.view!.presentScene(scene!, transition: trans)
        }
        else if(self.user.scoreByLevel == nbBone){
            self.user.level++
            nextScene(0.8, finish: true)
        }
    }
    
    override func keyDown(theEvent: NSEvent) {
        switch(theEvent.keyCode){
        case direction.LEFT.rawValue:
            if !user.sprite.hasActions(){
                user.sprite.texture = SKTexture(imageNamed: "pug_left")
                user.sprite.runAction(move_left)
            }
            break
        case direction.RIGHT.rawValue:
            if !user.sprite.hasActions(){
                user.sprite.texture = SKTexture(imageNamed: "pug_right")
                user.sprite.runAction(move_right)
            }
            break
        case direction.DOWN.rawValue:
            if !user.sprite.hasActions(){
                user.sprite.texture = SKTexture(imageNamed: "pug_down")
                user.sprite.runAction(move_down)
            }
            break
        case direction.UP.rawValue:
            if !user.sprite.hasActions(){
                user.sprite.texture = SKTexture(imageNamed: "pug_up")
                user.sprite.runAction(move_up)
            }
            break
        default:
            Swift.print("Autre")
        }
    }
    
    private func information(){
        self.lab_score.text = "Score = \(user.score)"
        self.lab_score.zPosition = 10
        self.lab_score.fontSize = 15
        self.lab_score.position = CGPoint(x: self.lab_score.frame.width, y: self.frame.height-30)
        self.addChild(self.lab_score)
        
        self.lab_level.text = "Level = \(user.level)"
        self.lab_level.zPosition = 10
        self.lab_level.fontSize = 15
        self.lab_level.position = CGPoint(x: self.frame.width/2, y: self.frame.height-30)
        self.addChild(self.lab_level)
        
        self.lab_life.text = "Life = \(self.user.life)"
        self.lab_life.zPosition = 10
        self.lab_life.fontSize = 15
        self.lab_life.position = CGPoint(x: (self.frame.width-self.lab_life.frame.width), y: self.frame.height-30)
        self.addChild(self.lab_life)
    }
    
    private func randomPoint() -> CGPoint {
        var p = CGPoint(x: randomX(), y: randomY())
        while nodeAtPoint(p).name != nil {
            p = CGPoint(x: randomX(), y: randomY())
        }
        return p
    }
    
    private func randomX() -> Int{
        return (Int(arc4random_uniform(29)+1))*32 + 48
    }
    
    private func randomY() -> Int{
        return (Int(arc4random_uniform(21)+1))*32 + 48
    }
    
    func createWall() -> SKSpriteNode{
        let trapTexture = SKTexture(imageNamed: "wall.png")
        wall = SKSpriteNode(texture: trapTexture, size: CGSize(width:32,height:32))
        wall.name = "wall"
        wall.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: wall.frame.width, height: wall.frame.height))
        wall.physicsBody!.dynamic = false
        wall.physicsBody!.pinned = true
        wall.physicsBody!.allowsRotation = false
        wall.physicsBody!.affectedByGravity = false
        wall.physicsBody!.categoryBitMask = category.wall.rawValue
        wall.physicsBody!.collisionBitMask = category.pug.rawValue
        return wall
    }
    
    
    func buildingWall(){
    
        var pos = 16

        for var i = 0; i < 31; i++ {
            wall = createWall()
            wall.zPosition = 2
            wall.position = CGPoint(x: pos, y: 16)
            self.addChild(wall)
            
            wall = createWall()
            wall.zPosition = 2
            wall.position = CGPoint(x: pos, y: 752)
            self.addChild(wall)
            
            if i < 24 {
                wall = createWall()
                wall.zPosition = 2
                wall.position = CGPoint(x: 16, y: pos)
                self.addChild(wall)
            
                wall = createWall()
                wall.zPosition = 2
                wall.position = CGPoint(x: 1008, y: pos)
                self.addChild(wall)
            }
            pos += 32
        }

        for var j = 0; j < nbWall; j++ {
            wall = createWall()
            let p = randomPoint()
            wall.position = p
            if j == 1 {
                createTube(p)
                wall.lightingBitMask = category.light.rawValue | category.tube_light.rawValue
            }
            else{
                wall.lightingBitMask = category.light.rawValue
            }
            self.addChild(wall)
        }

    }
    
    func createBone() {
        let trapTexture = SKTexture(imageNamed: "bone.png")
        bone = SKSpriteNode(texture: trapTexture, size: CGSize(width:32,height:32))
        bone.name = "bone"
        bone.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: bone.frame.width-2, height: bone.frame.height-2))
        bone.physicsBody!.dynamic = false
        bone.physicsBody!.allowsRotation = false
        bone.physicsBody!.affectedByGravity = false
        bone.physicsBody!.categoryBitMask = category.bone.rawValue
        bone.physicsBody!.contactTestBitMask = category.pug.rawValue
        bone.physicsBody!.collisionBitMask = 0
        bone.lightingBitMask = category.light.rawValue
        bone.position = randomPoint()
        
        self.addChild(bone)
    }
    
    func createTrap(){
        let trapTexture = SKTexture(imageNamed: "trap.png")
        trap = SKSpriteNode(texture: trapTexture, size: CGSize(width:32,height:32))
        trap.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: trap.frame.width-2, height: trap.frame.height-2))
        trap.name = "trap"
        trap.physicsBody!.dynamic = false
        trap.physicsBody!.allowsRotation = false
        trap.physicsBody!.affectedByGravity = false
        trap.physicsBody!.categoryBitMask = category.trap.rawValue
        trap.physicsBody!.collisionBitMask = 0
        trap.physicsBody!.contactTestBitMask = category.pug.rawValue
        trap.lightingBitMask = category.light.rawValue
        trap.position = randomPoint()
        self.addChild(trap)
    }

    func makeElement() {
        if(nbBone > nbTrap){
            for var i = 0; i < nbTrap; i++ {
                createBone()
                createTrap()
            }
            for var j = nbTrap; j < nbBone; j++ {
                createBone()
            }
        }
        else{
            for var i = 0; i < nbBone; i++ {
                createBone()
                createTrap()
            }
            for var j = nbBone; j < nbTrap; j++ {
                createTrap()
            }
        }
    }
    
    func createTube(p: CGPoint){
        let trapTexture = SKTexture(imageNamed: "tube.png")
        tube = SKSpriteNode(texture: trapTexture, size: CGSize(width:32,height:32))
        tube.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: tube.frame.width-2, height: tube.frame.height-2))
        tube.name = "tube"
        tube.physicsBody!.dynamic = false
        tube.physicsBody!.allowsRotation = false
        tube.physicsBody!.affectedByGravity = false
        tube.physicsBody!.categoryBitMask = category.tube.rawValue
        tube.physicsBody!.contactTestBitMask = category.pug.rawValue
        tube.physicsBody!.collisionBitMask = 0
        tube.position = p
        tube.hidden = true
        self.addChild(tube)
    }
    
    func createBackground(){
        let backTexture = SKTexture(imageNamed: "dirt_ground")
        let back = SKSpriteNode(texture: backTexture, size: self.frame.size)
        back.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        back.lightingBitMask = category.light.rawValue
        back.zPosition = -1
        self.addChild(back)
    }
    
    func nextScene(t: NSTimeInterval, finish: Bool){
        var direc : SKTransitionDirection = SKTransitionDirection.Left
        if user.level % 4 == 2 {
            direc = SKTransitionDirection.Left
        }
        else if user.level % 4 == 3 {
            direc = SKTransitionDirection.Up
        }
        else if user.level % 4 == 0 {
            direc = SKTransitionDirection.Right
        }
        else if user.level % 4 == 1 {
            direc = SKTransitionDirection.Down
        }
        var trans = SKTransition.pushWithDirection(direc, duration: 0.8)
        let scene = GameScene(size: self.size)
        if(finish){
            scene.nbBone = self.nbBone + 5
            scene.nbTrap = self.nbTrap + 5
        }
        else{
            scene.nbBone = self.nbBone - user.scoreByLevel + 2
            scene.nbTrap = self.nbTrap + 1
            trans = SKTransition.fadeWithColor(NSColor.whiteColor(), duration: t)
            
        }
        scene.user.level = self.user.level
        scene.user.score = self.user.score
        scene.user.life = self.user.life
        self.view!.presentScene(scene, transition: trans)
        
    }
    
}
