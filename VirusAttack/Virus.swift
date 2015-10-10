//
//  Virus.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/31.
//  Copyright (c) 2015 tobaru. All rights reserved.
//

import Foundation
import SpriteKit

class Virus: SKSpriteNode {

    var parentTooth:Tooth!
    var virusAttackTimer = NSTimer()
    let virusAttackTimeInterval:NSTimeInterval = 1
    
    init(tooth: Tooth) {
        
        self.parentTooth = tooth
        
        let texture = SKTexture(imageNamed: "virus_normal")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())

        self.virusAttackTimer = NSTimer.scheduledTimerWithTimeInterval(virusAttackTimeInterval, target: self, selector: "virusAttack", userInfo: nil, repeats: true)
        
        self.position = CGPointMake(25, 25)
        self.zPosition = 1
        let physicsBody = SKPhysicsBody(rectangleOfSize: self.frame.size)
        physicsBody.dynamic = true
        physicsBody.contactTestBitMask = 0x1 << 1
        self.physicsBody = physicsBody
        
        // runAction
        let parapraAction1 = SKAction.animateWithTextures(
            [
                SKTexture(imageNamed: "virus_attack"),
                SKTexture(imageNamed: "virus_attack_hardly"),
                SKTexture(imageNamed: "virus_attack"),
                SKTexture(imageNamed: "virus_attack_hardly")
            ],
            timePerFrame: 0.3)
        let paraparaRepeatAction1 =  SKAction.repeatActionForever(parapraAction1)
        self.runAction(paraparaRepeatAction1)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.virusAttackTimer.invalidate()
    }

    
    func virusAttack() {
        
        if (gameOverFlg == false) {

            parentTooth.setTimeProgress()
            let toothEnergy:Int = parentTooth.getTimeProgress()
            if (toothEnergy == 0) {
                
                // virusの勝ちで、歯にダメージ
                self.parentTooth.checkToothStatus()
                self.virusAttackTimer.invalidate()
                
                // むし歯数をカウントアップ
                cariesCount++
                
                // virus 勝ったアニメーション表示
                let scaleA = SKAction.scaleTo(1.0, duration: 0.5)
                let scaleB = SKAction.scaleTo(1.5, duration: 1.5)
                let scaleSequence = SKAction.sequence([scaleA,scaleB])
                let scalerepeatAction =  SKAction.repeatActionForever(scaleSequence)
                self.runAction(scalerepeatAction)
                
                let parapraAction1 = SKAction.animateWithTextures(
                    [SKTexture(imageNamed: "virus_normal"),
                        SKTexture(imageNamed: "virus_attack"),
                        SKTexture(imageNamed: "virus_attack_hardly")
                    ],
                    timePerFrame: 0.5)
                let paraparaRepeatAction1 =  SKAction.repeatActionForever(parapraAction1)
                self.runAction(paraparaRepeatAction1)
                
            }
            
        } else {
            // gameoverまでVirusが倒されない場合に通過する
            self.virusAttackTimer.invalidate()

        }
    }
    
    func invalidateTimer() {
        self.virusAttackTimer.invalidate()        
    }
}
