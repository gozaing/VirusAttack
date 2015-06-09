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

    var timer = NSTimer()
    var parentTooth:Tooth!
    
    init(tooth: Tooth) {
        
        self.parentTooth = tooth
        
        let texture = SKTexture(imageNamed: "s_virus_0")
        super.init(texture: texture, color: nil, size: texture.size())

        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "virusWin", userInfo: nil, repeats: true)
        
        self.position = CGPointMake(30, 30)
        let physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        physicsBody.dynamic = true
        physicsBody.contactTestBitMask = 0x1 << 1
        self.physicsBody = physicsBody
        
        // runAction
        let parapraAction1 = SKAction.animateWithTextures(
            [SKTexture(imageNamed: "s_virus_2"),
                SKTexture(imageNamed: "s_virus_0"),
                SKTexture(imageNamed: "s_virus_1")
            ],
            timePerFrame: 0.3)
        let paraparaRepeatAction1 =  SKAction.repeatActionForever(parapraAction1)
        self.runAction(paraparaRepeatAction1)
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func virusWin() {
        
        if (gameOverFlg == false) {

            parentTooth.setTimeProgress()
            var toothEnergy:Int = parentTooth.getTimeProgress()
            NSLog("toothEnergy->%d",toothEnergy)
            if (toothEnergy == 0) {
                
                // virusの勝ちで、歯にダメージ
                self.parentTooth.checkToothStatus()
                self.timer.invalidate()
                
                // virus 勝ったアニメーション表示
                let scaleA = SKAction.scaleTo(1.0, duration: 0.5)
                let scaleB = SKAction.scaleTo(1.5, duration: 1.5)
                let scaleSequence = SKAction.sequence([scaleA,scaleB])
                let scalerepeatAction =  SKAction.repeatActionForever(scaleSequence)
                self.runAction(scalerepeatAction)
                
                let parapraAction1 = SKAction.animateWithTextures(
                    [SKTexture(imageNamed: "s_virus_0"),
                        SKTexture(imageNamed: "s_virus_1"),
                        SKTexture(imageNamed: "s_virus_2")
                    ],
                    timePerFrame: 0.5)
                let paraparaRepeatAction1 =  SKAction.repeatActionForever(parapraAction1)
                self.runAction(paraparaRepeatAction1)
                
            }
            
        } else {
            NSLog("stop virus action for game over")
            self.timer.invalidate()
        }
    }
}
