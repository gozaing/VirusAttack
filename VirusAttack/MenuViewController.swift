//
//  MenuViewController.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/31.
//  Copyright (c) 2015 tobaru. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {

    private var menuImageView: UIImageView!
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println(self.view.bounds.width)
        println(self.view.bounds.height)
        
        // menu view
        let menuImage = UIImage(named: "menu")
        menuImageView = UIImageView(frame: CGRectMake(0,0,menuImage!.size.width,menuImage!.size.height))
        menuImageView.image = menuImage
        menuImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        self.view.addSubview(menuImageView)
        
        
        // 作成したViewを再背面へ
        self.view.sendSubviewToBack(menuImageView)
        
        // 歯ブラシアイコンSize
        let toothIconImageWidth = self.view.bounds.width/4
        let toothIconImageHeight = self.view.bounds.width/4
        
        // 歯ブラシアイコンPosition
        let toothIconPosX = self.view.bounds.width/5
        let toothIconPosY = (self.view.bounds.width/10)*2

        // 歯ブラシアイコン 1
        let toothIconImage1 = UIImage(named: "tooth_man_1")
        let toothIconImageView1 = UIImageView(frame: CGRectMake(0,0,toothIconImageWidth,toothIconImageHeight))
        toothIconImageView1.image = toothIconImage1
        toothIconImageView1.layer.position = CGPoint(x: toothIconPosX, y: toothIconPosY)
        self.view.addSubview(toothIconImageView1)

        // 歯ブラシアイコン 2
        let toothIconImage2 = UIImage(named: "tooth_man_2")
        let toothIconImageView2 = UIImageView(frame: CGRectMake(0,0,toothIconImageWidth,toothIconImageHeight))
        toothIconImageView2.image = toothIconImage2
        toothIconImageView2.layer.position = CGPoint(x: toothIconPosX*2, y: toothIconPosY)
        self.view.addSubview(toothIconImageView2)

        // 歯ブラシアイコン 3
        let toothIconImage3 = UIImage(named: "tooth_man_3")
        let toothIconImageView3 = UIImageView(frame: CGRectMake(0,0,toothIconImageWidth,toothIconImageHeight))
        toothIconImageView3.image = toothIconImage3
        toothIconImageView3.layer.position = CGPoint(x: toothIconPosX*3, y: toothIconPosY)
        self.view.addSubview(toothIconImageView3)

        // 歯ブラシアイコン 4
        let toothIconImage4 = UIImage(named: "tooth_man_4")
        let toothIconImageView4 = UIImageView(frame: CGRectMake(0,0,toothIconImageWidth,toothIconImageHeight))
        toothIconImageView4.image = toothIconImage4
        toothIconImageView4.layer.position = CGPoint(x: toothIconPosX*4, y: toothIconPosY)
        self.view.addSubview(toothIconImageView4)


        // game start button 1
        let gameStartImageWidth = (self.view.bounds.width/5)*2
        let gameStartImageHeight = (self.view.bounds.width/5)*2
        
        let gameStartButton1: UIButton = UIButton(frame: CGRectMake(0,0,gameStartImageWidth,gameStartImageHeight))
        gameStartButton1.backgroundColor = UIColor.redColor();
        gameStartButton1.layer.masksToBounds = true
        gameStartButton1.setTitle("start", forState: .Normal)
        gameStartButton1.layer.cornerRadius = 20.0
        gameStartButton1.layer.position = CGPoint(x: (self.view.bounds.width/4)*1 , y:self.view.bounds.height*0.35)
        gameStartButton1.tag = 1
        gameStartButton1.addTarget(self, action: "onClickStartGame:", forControlEvents: .TouchUpInside)
        
        gameStartButton1.setImage(UIImage(named: "cake_1"), forState: .Normal)
        self.view.addSubview(gameStartButton1)

        // game start button 2
        let gameStartButton2: UIButton = UIButton(frame: CGRectMake(0,0,gameStartImageWidth,gameStartImageHeight))
        gameStartButton2.backgroundColor = UIColor.redColor();
        gameStartButton2.layer.masksToBounds = true
        gameStartButton2.setTitle("start", forState: .Normal)
        gameStartButton2.layer.cornerRadius = 20.0
        gameStartButton2.layer.position = CGPoint(x: (self.view.bounds.width/4)*3 , y:self.view.bounds.height*0.35)
        gameStartButton2.tag = 2
        gameStartButton2.addTarget(self, action: "onClickStartGame:", forControlEvents: .TouchUpInside)
        gameStartButton2.setImage(UIImage(named: "cake_1"), forState: .Normal)
        self.view.addSubview(gameStartButton2)

        // game start button 3
        let gameStartButton3: UIButton = UIButton(frame: CGRectMake(0,0,gameStartImageWidth,gameStartImageHeight))
        gameStartButton3.backgroundColor = UIColor.redColor();
        gameStartButton3.layer.masksToBounds = true
        gameStartButton3.setTitle("start", forState: .Normal)
        gameStartButton3.layer.cornerRadius = 20.0
        gameStartButton3.layer.position = CGPoint(x: (self.view.bounds.width/4)*1 , y:self.view.bounds.height*0.60)
        gameStartButton3.tag = 3
        gameStartButton3.addTarget(self, action: "onClickStartGame:", forControlEvents: .TouchUpInside)
        
        gameStartButton3.setImage(UIImage(named: "cake_1"), forState: .Normal)
        self.view.addSubview(gameStartButton3)
        
        // game start button 4
        let gameStartButton4: UIButton = UIButton(frame: CGRectMake(0,0,gameStartImageWidth,gameStartImageHeight))
        gameStartButton4.backgroundColor = UIColor.redColor();
        gameStartButton4.layer.masksToBounds = true
        gameStartButton4.setTitle("start", forState: .Normal)
        gameStartButton4.layer.cornerRadius = 20.0
        gameStartButton4.layer.position = CGPoint(x: (self.view.bounds.width/4)*3 , y:self.view.bounds.height*0.60)
        gameStartButton4.tag = 4
        gameStartButton4.addTarget(self, action: "onClickStartGame:", forControlEvents: .TouchUpInside)
        gameStartButton4.setImage(UIImage(named: "cake_1"), forState: .Normal)
        self.view.addSubview(gameStartButton4)

        // tutorial view
        let helpImageWidht = self.view.bounds.width/4
        let helpImageHeight = self.view.bounds.width/4
        
        let helpButton: UIButton = UIButton(frame: CGRectMake(0,0,helpImageWidht,helpImageHeight))
        helpButton.backgroundColor = UIColor.whiteColor();
        helpButton.layer.masksToBounds = true
//        helpButton.setTitle("help", forState: .Normal)
        helpButton.layer.cornerRadius = 20.0
        helpButton.layer.position = CGPoint(x: (self.view.bounds.width/4)*1 , y:self.view.bounds.height*0.9)
        helpButton.addTarget(self, action: "onClickHelpView:", forControlEvents: .TouchUpInside)
        helpButton.setImage(UIImage(named: "question"), forState: .Normal)
        // ボタンを追加する.
        self.view.addSubview(helpButton)
        
        // score view
        let scoreImageWidht = self.view.bounds.width/4
        let scoreImageHeight = self.view.bounds.width/4

        let scoreButton: UIButton = UIButton(frame: CGRectMake(0,0,scoreImageWidht,scoreImageHeight))
        scoreButton.backgroundColor = UIColor.grayColor();
        scoreButton.layer.masksToBounds = true
        scoreButton.setTitle("score", forState: .Normal)
        scoreButton.layer.cornerRadius = 20.0
        scoreButton.layer.position = CGPoint(x: (self.view.bounds.width/4)*3 , y:self.view.bounds.height*0.9)
        scoreButton.addTarget(self, action: "onClickScoreView:", forControlEvents: .TouchUpInside)
        //        helpButton.setImage(UIImage(named: "cake_1"), forState: .Normal)
        // ボタンを追加する.
        self.view.addSubview(scoreButton)
    }
    
    @IBAction func backFromSecondView(segue:UIStoryboardSegue){
        NSLog("fromViewController")
    }
    
    @IBAction func onClickStartGame(sender:UIButton) {
        NSLog("onClickStartGame-gameLevel-%d",sender.tag)
        appDelegate.gameLevel = sender.tag
        let gameViewController: UIViewController = GameViewController()
        gameViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(gameViewController, animated: true, completion: nil)
    }

    @IBAction func onClickHelpView(sender:UIButton) {
        NSLog("onClickHelpView")
        let helpViewController: UIViewController = HelpViewController()
        helpViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(helpViewController, animated: true, completion: nil)
    }

    @IBAction func onClickScoreView(sender:UIButton) {
        NSLog("onClickScoreView")
        let scoreViewController: UIViewController = ScoreViewController()
        scoreViewController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(scoreViewController, animated: true, completion: nil)
    }
    
}
