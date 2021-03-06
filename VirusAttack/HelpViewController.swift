//
//  HelpViewController.swift
//  VirusAttack
//
//  Created by tobaru on 2015/06/20.
//  Copyright (c) 2015 tobaru. All rights reserved.
//

import Foundation
import UIKit

class HelpViewController: UIViewController {

    private var helpImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        // notification
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enterBackground:", name:"applicationDidEnterBackground", object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "enterForeground:", name:"applicationWillEnterForeground", object: nil)


        // help tutorial page
        let helpImage = UIImage(named: "bath_2_edit")
        helpImageView = UIImageView(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height))
        
        helpImageView.image = helpImage
        helpImageView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        self.view.addSubview(helpImageView)
        
        // 作成したViewを再背面へ
        self.view.sendSubviewToBack(helpImageView)

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
        
    
    }
    
    @IBAction func onClickGoHome(sender: UIButton) {
        NSLog("onClickGoHome")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
//    // notify function
//    func enterBackground(notification: NSNotification){
//        println("applicationDidEnterBackground")
//    }
//    
//    func enterForeground(notification: NSNotification){
//        println("applicationWillEnterForeground")
//    }

    
}
