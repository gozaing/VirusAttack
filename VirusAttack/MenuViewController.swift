//
//  MenuViewController.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/31.
//  Copyright (c) 2015年 tobaru. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {

    private var menuImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // menu view
        let menuImage = UIImage(named: "menu")
        menuImageView = UIImageView(frame: CGRectMake(0,0,menuImage!.size.width,menuImage!.size.height))
        menuImageView.image = menuImage
        menuImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        self.view.addSubview(menuImageView)
        
        // 作成したViewを再背面へ
        self.view.sendSubviewToBack(menuImageView)


        // game start button
        let gameStartButton: UIButton = UIButton(frame: CGRectMake(0,0,200,200))
        gameStartButton.backgroundColor = UIColor.redColor();
        gameStartButton.layer.masksToBounds = true
        gameStartButton.setTitle("start", forState: .Normal)
        gameStartButton.layer.cornerRadius = 20.0
        gameStartButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height*0.75)
        gameStartButton.addTarget(self, action: "onClickStartGame:", forControlEvents: .TouchUpInside)

        gameStartButton.setImage(UIImage(named: "cake_1"), forState: .Normal)
        // ボタンを追加する.
        self.view.addSubview(gameStartButton)
        
        // tutorial view
        
        
        

    }
    
    @IBAction func backFromSecondView(segue:UIStoryboardSegue){
        NSLog("fromViewController")
    }
    
    @IBAction func onClickStartGame(sender:UIButton) {
        NSLog("onClickStartGame")
        // 遷移するViewを定義する.
        let myGameViewController: UIViewController = GameViewController()
        // アニメーションを設定する.
        myGameViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        
        // Viewの移動する.
        self.presentViewController(myGameViewController, animated: true, completion: nil)
    }
    
}
