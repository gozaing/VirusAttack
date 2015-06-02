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
    
    
    init() {
        
        let texture = SKTexture(imageNamed: "s_tooth_0")
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "virusAppear", userInfo: nil, repeats: true)

        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkToothStatus", userInfo: nil, repeats: true)
        
        self.position = CGPointMake(240, 420)
        
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func virusAppear() {
        
        NSLog("virus->%d",self.virusCount)

        if (self.virusCount == 0) {
            NSLog("virusAppear")
            let virus = Virus(tooth: self)
            //virus.setScene(self)
            // TODO:ポジション
            //self.gameScene.addChild(virus)
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
            }
            

        }
    }
    
    func checkToothStatus() {
        // virusWinFlgが1なら、textureを変える
        
//        let arrayOfImages = [
//            "s_tooth_0",
//            "s_virus_0"
//        ]

        if virusWinFlg == 1 {
            NSLog("changeTexture")
            let loseTexture = SKTexture(imageNamed: "s_tooth_1")
            self.texture = loseTexture

        } else {
            NSLog("status=normal")
        }
    }
}
