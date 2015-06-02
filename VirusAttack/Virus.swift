//
//  Virus.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/31.
//  Copyright (c) 2015年 tobaru. All rights reserved.
//

import Foundation
import SpriteKit

class Virus: SKSpriteNode {
    var gameScene: SKScene!
    func setScene(scene: SKScene) {
        self.gameScene = scene
    }
    
    var timer = NSTimer()
    
    var parentTooth:Tooth!
    
    init(tooth: Tooth) {
        
        self.parentTooth = tooth
        
        let texture = SKTexture(imageNamed: "s_virus_0")
        super.init(texture: texture, color: nil, size: texture.size())
        
        //self.timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "disappear", userInfo: nil, repeats: true)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "virusWin", userInfo: nil, repeats: false)
        
        self.position = CGPointMake(10, 20)
        
        let physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        physicsBody.dynamic = true
        physicsBody.contactTestBitMask = 0x1 << 1
        self.physicsBody = physicsBody
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func disappear() {
//        NSLog("disappear")
//        self.removeFromParent()
//        self.timer.invalidate()
//        
//        self.parentTooth.setCount()
//
//    }
    
    func virusWin() {
        // virusの勝ちで、歯にダメージ
        self.parentTooth.setVirusWinFlg()
        
    }
}
