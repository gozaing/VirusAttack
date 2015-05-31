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
    
    init() {
        
        let texture = SKTexture(imageNamed: "s_tooth_0")
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "virusAppear", userInfo: nil, repeats: true)
        
        self.position = CGPointMake(240, 420)
        
        
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func virusAppear() {

        NSLog("virusAppear")
        let virus = Virus()
        virus.setScene(self.gameScene)
        // TODO:ポジション
        self.gameScene.addChild(virus)

    }    
}
