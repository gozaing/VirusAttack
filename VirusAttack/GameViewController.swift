//
//  ViewController.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/30.
//  Copyright (c) 2015 tobaru. All rights reserved.
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
//            view.showsFPS = true
//            view.showsNodeCount = true
            
            // シーンのサイズをビューに合わせる
            scene.size = view.frame.size
            
            // background
            let backGroundTexture = SKTexture(imageNamed: "bath_2_edit")
            let background = SKSpriteNode(texture: backGroundTexture)
            background.name = "background"
            background.size = CGSizeMake(self.view.bounds.width, self.view.bounds.height)
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
}

