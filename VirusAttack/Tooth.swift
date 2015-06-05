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
    
    var objIndexName:String?
    
    
    init(objIndex:Int) {
        
        let texture = SKTexture(imageNamed: "s_tooth_0")
        super.init(texture: texture, color: nil, size: texture.size())
        
        // random per seconds
        let intInterval = arc4random_uniform(10)
        NSLog("interval--%d",intInterval)
        let virusAppearSec = NSTimeInterval(intInterval)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(virusAppearSec, target: self, selector: "virusAppear", userInfo: nil, repeats: true)
        
        self.name = "tooth-" + objIndex.description
        
        self.objIndexName = objIndex.description
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func virusAppear() {
        
        if (self.virusCount == 0) {
            NSLog("virusAppear")
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
    }
    
    func winAction() {

        if (self.virusWinTimeCount > 0) {

            // reset
            self.setCount()
            self.setTimeClear()
            
            // runAction
            let jumpUp1 = SKAction.moveToY(self.position.y + 10, duration: 0.1)
            let jumpDown1 = SKAction.moveToY(self.position.y - 10, duration: 0.1)
            let jumpUp2 = SKAction.moveToY(self.position.y + 10, duration: 0.1)
            let jumpDown2 = SKAction.moveToY(self.position.y - 10, duration: 0.1)
            
            let jumpSequence = SKAction.sequence([jumpUp1,jumpDown1,jumpUp2,jumpDown2])
            self.runAction(jumpSequence)
        }

    }
    
    func checkToothStatus() {
        let loseTexture = SKTexture(imageNamed: "s_tooth_1")
        self.texture = loseTexture

        // virus 発生を止める
        self.timer.invalidate()
        
    }
}
