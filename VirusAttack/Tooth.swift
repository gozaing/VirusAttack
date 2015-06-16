//
//  Tooth.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/31.
//  Copyright (c) 2015年 tobaru. All rights reserved.
//

import Foundation
import SpriteKit

class Tooth: SKSpriteNode {
    var gameScene: SKScene!
    func setScene(scene: SKScene) {
        self.gameScene = scene
    }
    
    var virusAppearTimer = NSTimer()
    
    var virusCount:NSInteger = 0
    func setCount(){
        self.virusCount = 0
    }
    func getCount() -> NSInteger {
        return self.virusCount
    }
    
    var virusWinFlg:Int = 0
    func setVirusWinFlg() {
        self.virusWinFlg = 1
    }
    
    var virusWinTimeCount:Int = 10
    func setTimeClear(){
        self.virusWinTimeCount = 10
    }
    func setTimeProgress() {
        self.virusWinTimeCount -= 1
    }
    func getTimeProgress() -> NSInteger {
        return self.virusWinTimeCount
    }
    
    var objIndexName:String?
    
    
    init(objIndex:Int) {
        
        let texture = SKTexture(imageNamed: "s_tooth_0")
        super.init(texture: texture, color: nil, size: texture.size())
        
        // random per seconds
        let intInterval = arc4random_uniform(4) + 3
        NSLog("interval--%d",intInterval)
        let virusAppearSec = NSTimeInterval(intInterval)
        
        self.virusAppearTimer = NSTimer.scheduledTimerWithTimeInterval(virusAppearSec, target: self, selector: "virusAppear", userInfo: nil, repeats: true)
        
        self.name = "tooth-" + objIndex.description
        
        self.objIndexName = objIndex.description
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.virusAppearTimer.invalidate()
    }
    
    func virusAppear() {
        
        // gameoverか判定
        if (gameOverFlg == false) {
            
            if (self.virusCount == 0) {
//                NSLog("virusAppear")
                let virus = Virus(tooth: self)
                virus.name = "virus-" + self.objIndexName!
                self.addChild(virus)
                
                self.virusCount += 1
                
            } else {
                
                var existCount:Int = 0
                for children in self.children {
                    existCount += 1
                }
                if (existCount == 0) {
                    //self.winAction()
                }
            }

            
        } else {
            NSLog("tooth doesn't generate virus")
            self.virusAppearTimer.invalidate()

        }
        
    }
    
    // for happy texture
    var fineTextureTimer = NSTimer()
    
    func winAction() {

        if (self.virusWinTimeCount > 0) {

            // reset
            self.setCount()
            self.setTimeClear()
            
            // change texture
            let fineTexture = SKTexture(imageNamed: "s_tooth_2")
            self.texture = fineTexture
            
            // runAction
            let jumpUp1 = SKAction.moveBy(CGVector(dx: 0, dy: 10), duration:0.2)
            let jumpDown1 = SKAction.moveBy(CGVector(dx: 0, dy: -10), duration:0.2)
            let jumpUp2 = SKAction.moveBy(CGVector(dx: 0, dy: 10), duration:0.2)
            let jumpDown2 = SKAction.moveBy(CGVector(dx: 0, dy: -10), duration:0.2)
            
            let jumpSequence = SKAction.sequence([jumpUp1,jumpDown1,jumpUp2,jumpDown2])
            self.runAction(jumpSequence)
            
            self.fineTextureTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "changeNormalStatus", userInfo: nil, repeats: false)

        }

    }
    

    // textureを戻す
    func changeNormalStatus() {
        let normalTexture = SKTexture(imageNamed: "s_tooth_0")
        self.texture = normalTexture
        
        // timerを止める
        self.fineTextureTimer.invalidate()
    }
    
    func checkToothStatus() {
        let loseTexture = SKTexture(imageNamed: "s_tooth_1")
        self.texture = loseTexture

        // virus 発生を止める
        self.virusAppearTimer.invalidate()
        
    }
}
