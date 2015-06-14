//
//  ViewController.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/30.
//  Copyright (c) 2015年 tobaru. All rights reserved.
//

import UIKit
import SpriteKit

let homeIcon = UIButton(frame: CGRectMake(50, 400, 200, 50))

class ViewController: UIViewController {
    
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

            NSLog("start ViewController")
            
            // シーン作成
            let scene = GameScene()
            // SKView型で取り出す
            //        let view = self.view as! SKView
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
            
            // ボタンを生成
            homeIcon.setImage(UIImage(named: "home"), forState: .Normal)
            homeIcon.addTarget(self, action: "onClickHomeIcon:", forControlEvents: .TouchUpInside)
            homeIcon.alpha = CGFloat(0)
            self.view.addSubview(homeIcon)

            self.viewInitiated = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onClickHomeIcon(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}

