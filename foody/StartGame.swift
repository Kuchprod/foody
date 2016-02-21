//
//  StartGame.swift
//  foody
//
//  Created by Jonas Kucharz on 07/02/2016.
//  Copyright © 2016 Jonas Kucharz. All rights reserved.
//

import SpriteKit

class StartGame: SKScene {
    
    var button : SKNode!
    
    override func didMoveToView(view: SKView) {
        button = self.childNodeWithName("button_play")
        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        let click = theEvent.locationInNode(self)
        
        if self.nodeAtPoint(click).name == "button_play" {
            let trans = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameScene(size: self.size)
            self.view!.presentScene(scene, transition: trans)
        }
    }
}