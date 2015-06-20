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

    private var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 表示する画像を設定する.
        let myImage = UIImage(named: "menu")

        // UIImageViewを作成する.
        myImageView = UIImageView(frame: CGRectMake(0,0,myImage!.size.width,myImage!.size.height))
        
        // 画像をUIImageViewに設定する.
        myImageView.image = myImage
        
        // 画像の表示する座標を指定する.
        myImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        
        // UIImageViewをViewに追加する.
        self.view.addSubview(myImageView)
        
        // 作成したViewを再背面へ
        self.view.sendSubviewToBack(myImageView)

        // ボタンを生成する.
        let nextButton: UIButton = UIButton(frame: CGRectMake(0,0,200,200))
        nextButton.backgroundColor = UIColor.redColor();
        nextButton.layer.masksToBounds = true
        nextButton.setTitle("start", forState: .Normal)
        nextButton.layer.cornerRadius = 20.0
        nextButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height*0.75)
        nextButton.addTarget(self, action: "onClickStartGame:", forControlEvents: .TouchUpInside)

        nextButton.setImage(UIImage(named: "cake_1"), forState: .Normal)
        // ボタンを追加する.
        self.view.addSubview(nextButton)

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
