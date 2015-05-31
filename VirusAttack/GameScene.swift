//
//  GameScene.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/30.
//  Copyright (c) 2015年 tobaru. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene : SKScene, SKPhysicsContactDelegate {

    // ブラシ
    var brush:SKSpriteNode?
    // timer
    var timer:NSTimer?
    
    // tooth1
    var tooth1:Tooth?

    override func didMoveToView(view: SKView) {
        
        // 衝突プロトコルの発生
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -0.01)
        self.physicsWorld.contactDelegate = self
        
        // timer start
//        self.timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "appearTooth", userInfo: nil, repeats: true)
        
        let brushTexture = SKTexture(imageNamed: "toothbrush")
        let brush = SKSpriteNode(texture: brushTexture)
        brush.position = CGPoint(x: self.size.width*0.5, y:100)
        brush.size = CGSize(width: brushTexture.size().width*0.5, height: brushTexture.size().height*0.5)
        brush.physicsBody = SKPhysicsBody(texture: brushTexture, size: brush.size)
        brush.physicsBody?.dynamic = false
        
        // add physics
        let physicsBody = SKPhysicsBody(rectangleOfSize: brush.frame.size)
        physicsBody.dynamic = true
        physicsBody.contactTestBitMask = 0x1 << 1
        brush.physicsBody = physicsBody
        
        self.brush = brush
        self.addChild(brush)
        
//        // ------ tooth
//        let toothTexture = SKTexture(imageNamed: "s_tooth_0")
//        let tooth = SKSpriteNode(texture: toothTexture)
//        tooth.position = CGPoint(x: self.size.width*0.5, y:100)
//        tooth.size = CGSize(width: toothTexture.size().width*0.5, height: toothTexture.size().height*0.5)
//
//        self.addChild(tooth)
        
        
        self.appearTooth()
    }

    func appearTooth() {
        
        let tooth = Tooth()
        tooth.setScene(self)
        // TODO:ポジション
        self.addChild(tooth)
        self.tooth1 = tooth
    }
    
    // タッチ開始時
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch: AnyObject = touches.first {
            let location = touch.locationInNode(self)
            let action = SKAction.moveTo(CGPointMake(location.x, location.y), duration: 0.1)
            self.brush?.runAction(action)
            
        }
    }
    
    // ドラッグ時
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch: AnyObject = touches.first {
            let location = touch.locationInNode(self)
            let action = SKAction.moveTo(CGPointMake(location.x, location.y), duration: 0.1)
            self.brush?.runAction(action)
            
        }
    }
    
    // 衝突判定
    func didBeginContact(contact: SKPhysicsContact) {
        NSLog("collision")

        if contact.bodyA.node == self.brush {
            var targetNode:SKNode? = contact.bodyB.node
            targetNode!.removeFromParent()
            
            self.tooth1?.setCount()

            
        }else if (contact.bodyB.node == self.brush){
            var targetNode:SKNode? = contact.bodyA.node
            targetNode!.removeFromParent()
            self.tooth1?.setCount()

        }
    }
}
