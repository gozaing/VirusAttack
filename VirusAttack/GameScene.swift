//
//  GameScene.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/30.
//  Copyright (c) 2015 tobaru. All rights reserved.
//

import Foundation
import SpriteKit

// ゲームオーバー
var gameOverFlg:Bool = false
//ポイント
var point:NSInteger = 0
//ラベル
let gameoverLabel = SKLabelNode(fontNamed:"Hiragino Kaku Gothic ProN")
let pointLabel = SKLabelNode(fontNamed:"Hiragino Kaku Gothic ProN")
// button

var reloadIcon = UIButton()
var homeIcon = UIButton()

let screenWidth = UIScreen.mainScreen().bounds.size.width
let screenHeight = UIScreen.mainScreen().bounds.size.height


// プレイ中フラグ
var gamePlayingFlg:Bool = false

class GameScene : SKScene, SKPhysicsContactDelegate {
    
    //AppDelegateのインスタンスを取得
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    // 得点を保持
    var myUserDafault:NSUserDefaults = NSUserDefaults()
    // ブラシ
    var brush:SKSpriteNode?
    // gameOverTimer
    var gameOverTimer:NSTimer?
    // gameOverTime
    let gameOverTime: NSTimeInterval = 20

    // viewControllerをGameSceneで保持し、menuに戻るdissmissに利用
    var GameViewController: UIViewController!

    func gameStart() {
        
        gameOverFlg = false
        point = 0
        gamePlayingFlg = true

        self.brush = nil
        self.gameOverTimer = nil
        
        let homeIconPosX = (screenWidth/5)*2
        let homeIconPosY = (screenHeight/10)*6
        let homeIconWidth = (screenWidth/5)*2.5
        let homeIconHeight = (screenWidth/5)*1.5
        
        let reloadIconPosX = (screenWidth/5)*0.8
        let reloadIconPosY = (screenHeight/10)*6
        let reloadIconWidth = (screenWidth/5)*2.5
        let reloadIconHeight = (screenWidth/5)*1.5

        
        homeIcon = UIButton(frame: CGRectMake(homeIconPosX, homeIconPosY, homeIconWidth, homeIconHeight))
        
        reloadIcon = UIButton(frame: CGRectMake(reloadIconPosX, reloadIconPosY, reloadIconWidth, reloadIconHeight))
        
        
        // gameOverTimer start
        self.gameOverTimer = NSTimer.scheduledTimerWithTimeInterval(gameOverTime, target: self, selector: "gameOver", userInfo: nil, repeats: false)
        
        // 衝突プロトコルの発生
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        let brush = SKSpriteNode()
//        brush.color = UIColor.greenColor()
        brush.position = CGPoint(x: 0, y:0)
        brush.zPosition = 2

        let brushIconWidth = screenWidth/20
        let brushIconHeight = screenHeight/60

        brush.size = CGSizeMake(brushIconWidth, brushIconHeight)
        
        // add physics
        let physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(brush.size.width, brush.size.height))
        physicsBody.dynamic = true
        physicsBody.contactTestBitMask = 0x1 << 1
        brush.physicsBody = physicsBody
        
        self.brush = brush
        self.addChild(brush)
        
        // ------------------------------------------
        // MenuViewControllerで選択したレベルをAppDelegate経由で取得
        var widthCount:Int = 0
        var heightCount:Int = 0

        let level = appDelegate.gameLevel
        if (level == 2) {
            widthCount = 3
            heightCount = 4
        } else if (level == 3) {
            widthCount = 4
            heightCount = 5
        } else if (level == 4) {
            widthCount = 5
            heightCount = 7
        } else {
            widthCount = 2
            heightCount = 3
        }
        // ------------------------------------------
        
        let toothPerWidth = Int(self.size.width / CGFloat(widthCount))
        let toothPerHeight = Int(self.size.height / CGFloat(heightCount))
        
        // 歯オブジェクトの名前用
        var toothCount = 1
        
        
        // 幅から横並びの歯の数を算出
        for (var i = 1; i < widthCount; i++) {

            // 高さから歯の数を算出
            for (var j = 1; j < heightCount; j++) {

                // 案)
                // DictionaryでposX/posY/time/energyなどを保持
                // generate func で生成
                // game start / pause でDictionaryの値を使ってgenerate
                // 毎秒または毎フレームでDictionaryの内容を更新


                let tooth = Tooth(objIndex:toothCount)
                tooth.setScene(self)
                var toothPosX :CGFloat = CGFloat(toothPerWidth * i)
                var toothPosY :CGFloat = CGFloat(toothPerHeight * j)
                
                tooth.position = CGPointMake( toothPosX , toothPosY)
                self.addChild(tooth)
                
                toothCount++
                println(toothCount)

            }

        }

    }
    
    func reloadGame() {
        
        // iconの削除
        homeIcon.removeFromSuperview()
        reloadIcon.removeFromSuperview()
        
        for Node : AnyObject in self.children{
            
            if (Node as! SKNode).name == nil  {
                println("name is nil")
                Node.removeFromParent()
            }
            else{
                if Node.name == "background" {
                    println("name is background")
                }
                else {
                    Node.removeFromParent()
                }
            }
            
            
        }
        
        self.paused = false
        self.gameStart()
    }


    let tapToResume = SKLabelNode(fontNamed: "Noteworthy")

    override func didMoveToView(view: SKView) {
        
        NSLog("didMoveToView")
        
        self.gameStart()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "PauseScene:", name:"applicationWillResignActive", object: nil)
        
        
    }
    
    func timerInvalidate() {
        // 全オブジェクトのNSTimerをinvalidateする
        for Node : AnyObject in self.children{
            
            if (Node as! SKNode).name != nil  {
                if Node.name == "background" {
                    println("name is background")
                }
                else {
                    println("name is exist")
                    println( (Node as! SKNode).name )
                    
                    let actualChildName = (Node as! SKNode).name ?? "Undefined"
                    // virus-10という形で取れる -以降を取り出す
                    let virusNameIndex = (actualChildName as NSString).rangeOfString("-").location
                    let objIndex = (actualChildName as NSString).substringFromIndex(virusNameIndex + 1 )
                    
                    var parentTooth = self.childNodeWithName("tooth-" + objIndex) as! Tooth
                    parentTooth.invalidateTimer()
                    
                    var virus:Virus?
                    virus = parentTooth.childNodeWithName("virus-" + objIndex) as? Virus
                    virus?.invalidateTimer()
                    
                    // game over timer stop
                    self.gameOverTimer?.invalidate()
                    
                }
            }
        }
    }


    func PauseScene(notification: NSNotification) {
        NSLog("get PauseScene")

        // NSTimerをinvalidateする
        self.timerInvalidate()
        
        // back to home menu
        self.GameViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func gameOver() {
        NSLog("gameOver")
        
        // Game Over Label
        gameoverLabel.text = "GAME OVER"
        gameoverLabel.fontSize = screenWidth/8
        gameoverLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        gameoverLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        gameoverLabel.zPosition = 2
        gameoverLabel.removeFromParent()
        self.addChild(gameoverLabel)
 
        // gameover状態にする
        gameOverFlg = true
        
        // ポイントラベル
        pointLabel.fontSize = screenWidth/8
        pointLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        pointLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)+100)
        pointLabel.zPosition = 2
        
        pointLabel.removeFromParent()
        var pointString:String = "\(point)点"
        pointLabel.text = pointString
        self.addChild(pointLabel)
        
        // NSUserDefaultに1-3位の得点を保持
        setMaxPoint(point)

        // もう一度
        reloadIcon.setImage(UIImage(named: "reload"), forState: .Normal)
        reloadIcon.addTarget(self, action: "clickReload:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(reloadIcon)

        // ホーム画面に戻る
        homeIcon.setImage(UIImage(named: "home"), forState: .Normal)
        homeIcon.addTarget(self, action: "backToMenu:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(homeIcon)
        
        // Tooth,VirusのNSTimerを止める
        self.timerInvalidate()
    }
    
    func backToMenu (sender: UIButton) {
        self.GameViewController.dismissViewControllerAnimated(true, completion: nil)
        

    }
    
    func clickReload(sender: UIButton) {
        self.reloadGame()
    }
    
    // タッチ開始時
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if let touch: AnyObject = touches.first {
            let location = touch.locationInNode(self)
//            let action = SKAction.moveTo(CGPointMake(location.x, location.y), duration: 0.1)
//            self.brush?.runAction(action)
            // 移動中のオブジェクトも対象となるため、movetoは使わない
            self.brush?.position = CGPoint(x: location.x, y: location.y)
        }
    }
    
//    // ドラッグ時
//    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
//        if let touch: AnyObject = touches.first {
//            let location = touch.locationInNode(self)
//            let action = SKAction.moveTo(CGPointMake(location.x, location.y), duration: 0.1)
//            self.brush?.runAction(action)
//            
//        }
//    }
    
    // 毎フレーム呼び出される
    override func update(currentTime: NSTimeInterval) {
//        if (gamePlayingFlg == true) {
//            if self.gameOverTimer?.valid == true {
//                self.gameOverTimer?.invalidate()
//            }
//        } else {
//            if self.gameOverTimer?.valid == false {
//                self.gameOverTimer?.fire()
//            }
//        }
    }
    
    // 衝突判定
    func didBeginContact(contact: SKPhysicsContact) {

        if contact.bodyA.node == self.brush {
            var targetNode:SKNode? = contact.bodyB.node
            
            let actualChildName = targetNode?.name ?? "Undefined"
            // virus-10という形で取れる -以降を取り出す
            let virusNameIndex = (actualChildName as NSString).rangeOfString("-").location
            let objIndex = (actualChildName as NSString).substringFromIndex(virusNameIndex + 1 )
            
            var parentTooth = self.childNodeWithName("tooth-" + objIndex) as! Tooth
            var virus:Virus?
            virus = parentTooth.childNodeWithName("virus-" + objIndex) as? Virus
            virus?.virusAttackTimer.invalidate()
                
            // parent run Action
            parentTooth.winAction()

            targetNode!.removeFromParent()
            
            // 加算
            point += 1

        }else if (contact.bodyB.node == self.brush){

            var targetNode:SKNode? = contact.bodyA.node
            
            let actualChildName = targetNode?.name ?? "Undefined"
            // virus-10という形で取れる -以降を取り出す
            let virusNameIndex = (actualChildName as NSString).rangeOfString("-").location
            let objIndex = (actualChildName as NSString).substringFromIndex(virusNameIndex + 1 )
            
            var parentTooth = self.childNodeWithName("tooth-" + objIndex) as! Tooth
            var virus:Virus?
            virus = parentTooth.childNodeWithName("virus-" + objIndex) as? Virus
            virus?.virusAttackTimer.invalidate()
            
            // parent run Action
            parentTooth.winAction()
            
            targetNode!.removeFromParent()
            
            // 加算
            point += 1
        }
    }
    
    // scoreを比較してNSUserDefaultに格納
    func setMaxPoint(scorePoint:Int) {
        
        // NSUserDefaultに最高点を保持
        var firstPoint:Int = myUserDafault.integerForKey("FirstPoint")
        var secondPoint:Int = myUserDafault.integerForKey("SecondPoint")
        var thirdPoint:Int = myUserDafault.integerForKey("ThirdPoint")
        
        NSLog("FirstPoint->%d",firstPoint)
        NSLog("SecondPoint->%d",secondPoint)
        NSLog("ThirdPoint->%d",thirdPoint)
        
        if (thirdPoint < scorePoint ) {
            // 2位?
            if (secondPoint < scorePoint ) {
            
                // 1位?
                if (firstPoint < scorePoint ) {
                    // 1位確定
                    NSLog("save FirstPoint")
                    myUserDafault.setObject(scorePoint, forKey: "FirstPoint")
                    myUserDafault.setObject(firstPoint, forKey: "SecondPoint")
                    myUserDafault.setObject(secondPoint, forKey: "ThirdPoint")
                } else {
                    // 2位確定
                    NSLog("save SecondPoint")
                    myUserDafault.setObject(scorePoint, forKey: "SecondPoint")
                    myUserDafault.setObject(secondPoint, forKey: "ThirdPoint")
                }

            }else{
                // 3位確定
                NSLog("save ThirdPoint")
                myUserDafault.setObject(scorePoint, forKey: "ThirdPoint")
            }
        }
    }
    
}
