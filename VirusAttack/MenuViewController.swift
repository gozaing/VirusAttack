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
//        let myImage = UIImage(named: "test_iphone6")
        let myImage = UIImage(named: "bath_750_1334")

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

    }
    
    @IBAction func backFromSecondView(segue:UIStoryboardSegue){
        NSLog("fromViewController")
    }
}
