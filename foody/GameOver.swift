//
//  GameOver.swift
//  foody
//
//  Created by Jonas Kucharz on 18/02/2016.
//  Copyright © 2016 Jonas Kucharz. All rights reserved.
//

import SpriteKit

class GameOver : SKScene {
    
    var background : SKNode!
    var button_play : SKNode!
    var button_quit : SKNode!
    
    override func didMoveToView(view: SKView) {
        button_play = self.childNodeWithName("rejouer")
        button_quit = self.childNodeWithName("quitter")
        
    }
    
    override func mouseDown(theEvent: NSEvent) {
        let click = theEvent.locationInNode(self)
        
        if self.nodeAtPoint(click).name == "rejouer" {
            let trans = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameScene(fileNamed:"GameScene")
            scene!.scaleMode = .Fill
            self.view!.presentScene(scene!, transition: trans)
        }
        else if self.nodeAtPoint(click).name == "quitter" {
            NSApplication.sharedApplication().terminate(self)
        }
    }
}