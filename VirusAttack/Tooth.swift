//
//  Tooth.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/31.
//  Copyright (c) 2015 tobaru. All rights reserved.
//

import Foundation
import SpriteKit

class Tooth: SKSpriteNode {
    var gameScene: SKScene!
    func setScene(scene: SKScene) {
        self.gameScene = scene
    }
    
    var virusAppearTimer = NSTimer()
    var gamePlayCheckTimer = NSTimer()
    
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
        
        timerInitialized()
        
        self.name = "tooth-" + objIndex.description
        
        self.objIndexName = objIndex.description
        
        // Game中か確認するタイマー
        self.gamePlayCheckTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "timerCheck", userInfo: nil, repeats: true)
        
    }
    
    func timerInitialized() {
        // random per seconds
        let intInterval = arc4random_uniform(4) + 3
        NSLog("interval--%d",intInterval)
        let virusAppearSec = NSTimeInterval(intInterval)

        self.virusAppearTimer = NSTimer.scheduledTimerWithTimeInterval(virusAppearSec, target: self, selector: "virusAppear", userInfo: nil, repeats: true)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.virusAppearTimer.invalidate()
    }
    
    func virusAppear() {
        
        NSLog("virusAppear")
        
        // gameoverか判定
        if (gameOverFlg == false) {
            
            if (self.virusCount == 0) {
                let virus = Virus(tooth: self)
                virus.name = "virus-" + self.objIndexName!
                self.addChild(virus)
                
                self.virusCount += 1
                
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
        NSLog("changeNormalStatus")
        let normalTexture = SKTexture(imageNamed: "s_tooth_0")
        self.texture = normalTexture
        
        // timerを止める
        self.fineTextureTimer.invalidate()
    }
    
    // Virusクラスから利用される
    func checkToothStatus() {
        let loseTexture = SKTexture(imageNamed: "s_tooth_1")
        self.texture = loseTexture

        // virus 発生を止める
        self.virusAppearTimer.invalidate()
        
    }
    
    func timerCheck() {
        NSLog("timerCheck")
        println(virusAppearTimer.valid)
        if gamePlayingFlg == true {
            
            // ゲームが再開 ゲーム中
            if virusAppearTimer.valid == false {
                timerInitialized()
                NSLog("timerCheck--initilized")
            }

        } else {
        
            // ゲーム終了中
            if virusAppearTimer.valid == true {
                virusAppearTimer.invalidate()
                NSLog("timerCheck--invalidate")
            }
        }
        
    }
    
    func invalidateTimer() {
        NSLog("tooth-invalidateTimer")
        if self.virusAppearTimer.valid == true {
            self.virusAppearTimer.invalidate()
        }
        
        if self.fineTextureTimer.valid == true {
            self.fineTextureTimer.invalidate()
        }
        
        if self.gamePlayCheckTimer.valid == true {
            self.gamePlayCheckTimer.invalidate()
        }
    }
}
