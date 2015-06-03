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
    
    var timer = NSTimer()
    
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
    
    
    init() {
        
        let texture = SKTexture(imageNamed: "s_tooth_0")
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "virusAppear", userInfo: nil, repeats: true)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func virusAppear() {
        
        NSLog("virus->%d",self.virusCount)

        if (self.virusCount == 0) {
            NSLog("virusAppear")
            let virus = Virus(tooth: self)
            virus.name = "virus-1"
            self.addChild(virus)
            
            self.virusCount += 1
            
        } else {

            var existCount:Int = 0
            for children in self.children {
                println("exist!")
                existCount += 1
            }
            if (existCount == 0) {
                println("set count clear")
                self.setCount()
                self.setTimeClear()
                
                // ちょっと移動
                let jumpUp1 = SKAction.moveToY(self.position.y + 10, duration: 0.1)
                let jumpDown1 = SKAction.moveToY(self.position.y - 10, duration: 0.1)
                let jumpUp2 = SKAction.moveToY(self.position.y + 10, duration: 0.1)
                let jumpDown2 = SKAction.moveToY(self.position.y - 10, duration: 0.1)
                
                let jumpSequence = SKAction.sequence([jumpUp1,jumpDown1,jumpUp2,jumpDown2])
                self.runAction(jumpSequence)

            }
            

        }
    }
    
    func checkToothStatus() {
        // virusWinFlgが1なら、textureを変える
        
        NSLog("changeTexture")
        let loseTexture = SKTexture(imageNamed: "s_tooth_1")
        self.texture = loseTexture

        // virus 発生を止める
        self.timer.invalidate()
        
    }
}
