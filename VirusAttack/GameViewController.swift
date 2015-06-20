//
//  ViewController.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/30.
//  Copyright (c) 2015年 tobaru. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController {
    
    var viewInitiated: Bool = false
    
    override func loadView() {
        let skView = SKView()
        self.view = skView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enterBackground:", name:"applicationDidEnterBackground", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pauseGameScene:", name:"applicationWillEnterForeground", object: nil)

    }
    
    override func viewWillLayoutSubviews() {
        if(!viewInitiated){
            super.viewWillLayoutSubviews()

            // シーン作成
            let scene = GameScene()

            scene.GameViewController = self
            
            // SKView型で取り出す
            let view = self.view as! SKView
            
            // debug info
            view.showsFPS = true
            view.showsNodeCount = true
            
            // シーンのサイズをビューに合わせる
            scene.size = view.frame.size
            
            // background
            let backGroundTexture = SKTexture(imageNamed: "bath_750_1334")
            let background = SKSpriteNode(texture: backGroundTexture)
            background.name = "background"
            background.position = CGPoint(x: scene.size.width/2 , y: scene.size.height/2)
            scene.addChild(background)
            
            // ビューの上にシーンを作成
            view.presentScene(scene)

            self.viewInitiated = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // notify function
    func enterBackground(notification: NSNotification){
        println("applicationDidEnterBackground")
    }
    
    func enterForeground(notification: NSNotification){
        println("applicationWillEnterForeground")
        
        // scene kit puase = false
    }

    func pauseGameScene(notification: NSNotification){
        println("pauseGameScene")
        
        // scene kit pause change
        
        
        
    }
}

