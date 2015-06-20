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
        let helpButton: UIButton = UIButton(frame: CGRectMake(0,0,100,100))
        helpButton.backgroundColor = UIColor.grayColor();
        helpButton.layer.masksToBounds = true
        helpButton.setTitle("help", forState: .Normal)
        helpButton.layer.cornerRadius = 20.0
        helpButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height*0.5)
        helpButton.addTarget(self, action: "onClickHelpMenu:", forControlEvents: .TouchUpInside)
//        helpButton.setImage(UIImage(named: "cake_1"), forState: .Normal)
        // ボタンを追加する.
        self.view.addSubview(helpButton)
        
        
        

    }
    
    @IBAction func backFromSecondView(segue:UIStoryboardSegue){
        NSLog("fromViewController")
    }
    
    @IBAction func onClickStartGame(sender:UIButton) {
        NSLog("onClickStartGame")
        let gameViewController: UIViewController = GameViewController()
        gameViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(gameViewController, animated: true, completion: nil)
    }

    @IBAction func onClickHelpMenu(sender:UIButton) {
        NSLog("onClickHelpMenu")
        let helpViewController: UIViewController = HelpViewController()
        helpViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(helpViewController, animated: true, completion: nil)
    }
    
}
