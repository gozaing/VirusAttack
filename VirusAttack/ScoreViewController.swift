//
//  ScoreViewController.swift
//  VirusAttack
//
//  Created by tobaru on 2015/06/21.
//  Copyright (c) 2015 tobaru. All rights reserved.
//

import Foundation
import UIKit

class ScoreViewController: UIViewController {
    
    private var scoreImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // help tutorial page
        let scoreImage = UIImage(named: "bath_2_edit")
        scoreImageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        
        scoreImageView.image = scoreImage
        scoreImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        self.view.addSubview(scoreImageView)
        
        // 作成したViewを再背面へ
        self.view.sendSubviewToBack(scoreImageView)
        
        // goto home button
        let homeButton: UIButton = UIButton(frame: CGRectMake(0,0,100,100))
        homeButton.backgroundColor = UIColor.whiteColor();
        homeButton.layer.masksToBounds = true
        // 追加すると画像横にテキストが表示される為コメントアウト
        // homeButton.setTitle("home", forState: .Normal)
        homeButton.layer.cornerRadius = 20.0
        homeButton.layer.position = CGPoint(x: self.view.bounds.width/2 , y:self.view.bounds.height*0.9)
        homeButton.addTarget(self, action: "onClickGoHome:", forControlEvents: .TouchUpInside)
        homeButton.setImage(UIImage(named: "home"), forState: .Normal)
        // ボタンを追加する.
        self.view.addSubview(homeButton)
        
        //UserDefaultの生成
        var myUserDafault:NSUserDefaults = NSUserDefaults()
        //登録されているUserDefaultから得点を呼び出す
        var firstPoint:Int = myUserDafault.integerForKey("FirstPoint")
        var secondPoint:Int = myUserDafault.integerForKey("SecondPoint")
        var thirdPoint:Int = myUserDafault.integerForKey("ThirdPoint")

        //得点ラベル
        let dispLabel: UILabel = UILabel(frame: CGRectMake(0,0,300,200))
        dispLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: self.view.frame.height/2 - 100)
        
        dispLabel.text = "POINT"
        dispLabel.font = UIFont(name: "HiraKakuProN-W3", size: 50)
        dispLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(dispLabel)
        
        let pointBaseHeight = self.view.frame.height/10

        //取り出した最高点を表示するためのUILabel
        let firstPointLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,100))
        firstPointLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: pointBaseHeight*5)
        
        firstPointLabel.text = "\(firstPoint)"
        firstPointLabel.font = UIFont(name: "HiraKakuProN-W3", size: 60)
        firstPointLabel.textAlignment = NSTextAlignment.Right
        self.view.addSubview(firstPointLabel)
        
        let secondPointLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,200))
        secondPointLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: pointBaseHeight*6)
        
        secondPointLabel.text = "\(secondPoint)"
        secondPointLabel.font = UIFont(name: "HiraKakuProN-W3", size: 60)
        secondPointLabel.textAlignment = NSTextAlignment.Right
        self.view.addSubview(secondPointLabel)

        let thirdPointLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,300))
        thirdPointLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: pointBaseHeight*7)
        
        thirdPointLabel.text = "\(thirdPoint)"
        thirdPointLabel.font = UIFont(name: "HiraKakuProN-W3", size: 60)
        thirdPointLabel.textAlignment = NSTextAlignment.Right
        self.view.addSubview(thirdPointLabel)
        
        
        
    }
    
    @IBAction func onClickGoHome(sender: UIButton) {
        NSLog("onClickGoHome")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}

