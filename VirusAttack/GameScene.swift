//
//  GameScene.swift
//  VirusAttack
//
//  Created by tobaru on 2015/05/30.
//  Copyright (c) 2015年 tobaru. All rights reserved.
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
let reloadIcon = UIButton(frame: CGRectMake(150, 400, 200, 50))
let homeIcon = UIButton(frame: CGRectMake(50, 400, 200, 50))
let replayIcon = UIButton(frame: CGRectMake(100, 300, 200, 50))

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

    
//    var gamePaused : Bool = false {
//        didSet {
//            self.paused = gamePaused
//        }
//    }
//    override var paused : Bool {
//        get {
//            return gamePaused
//        }
//        set {
//            super.paused = gamePaused
//        }
//    }
    
    func gameStart() {
        
        gameOverFlg = false
        point = 0

        self.brush = nil
        self.gameOverTimer = nil
        
        // gameOverTimer start
        self.gameOverTimer = NSTimer.scheduledTimerWithTimeInterval(gameOverTime, target: self, selector: "gameOver", userInfo: nil, repeats: false)
        
        // 衝突プロトコルの発生
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        let brush = SKSpriteNode()
//        brush.color = UIColor.greenColor()
        brush.position = CGPoint(x: self.size.width*0.5, y:100)
        brush.zPosition = 2
        brush.size = CGSizeMake(40, 40)
        
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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "startScene:", name:"applicationDidBecomeActive", object: nil)
        
        replayIcon.setImage(UIImage(named: "home"), forState: .Normal)
        replayIcon.addTarget(self, action: "replayGame:", forControlEvents: .TouchUpInside)
        replayIcon.hidden = true
        self.view!.addSubview(replayIcon)


        
    }


    func PauseScene(notification: NSNotification) {
        NSLog("get PauseScene")
//        self.paused = true
//        self.view?.paused = true
//        println(self.speed)
//        tapToResume.hidden = false
        self.paused = true
//        self.view?.paused = true
//        self.speed = 0.0
//        self.view?.scene?.paused = true
        

        
    }
    func startScene(notification: NSNotification) {
        NSLog("get startScene")
//        self.paused = false
//        self.view?.paused = false
//        println(self.speed)
        replayIcon.hidden = false
        
    }
    
    func replayGame(sender:UIButton){
        NSLog("replayGame")
        self.paused = false
//        self.view?.paused = false
//        self.speed = 1.0
    }
    
    func gameOver() {
        
        // Game Over Label
        gameoverLabel.text = "GAME OVER"
        gameoverLabel.fontSize = 60
        gameoverLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        gameoverLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        gameoverLabel.zPosition = 2
        gameoverLabel.removeFromParent()
        self.addChild(gameoverLabel)
 
        // gameover状態にする
        gameOverFlg = true
        
        self.gameOverTimer?.invalidate()
        self.paused = true
        
        // ポイントラベル
        pointLabel.fontSize = 60
        pointLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        pointLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)+100)
        pointLabel.zPosition = 2
        
        pointLabel.removeFromParent()
        var pointString:String = "\(point)点"
        pointLabel.text = pointString
        self.addChild(pointLabel)
        
        // NSUserDefaultに最高点を保持
        var maxPoint:Int = myUserDafault.integerForKey("MaxPoint")
        NSLog("maxPoint->%d",maxPoint)
        if (maxPoint < point ) {
            NSLog("save maxpoint")
            //最高点を超えていたら保持する
            myUserDafault.setObject(point, forKey: "MaxPoint")
        }

        // もう一度
        reloadIcon.setImage(UIImage(named: "reload"), forState: .Normal)
        reloadIcon.addTarget(self, action: "clickReload:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(reloadIcon)

        // ホーム画面に戻る
        homeIcon.setImage(UIImage(named: "home"), forState: .Normal)
        homeIcon.addTarget(self, action: "backToMenu:", forControlEvents: .TouchUpInside)
        self.view!.addSubview(homeIcon)
        
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
            let action = SKAction.moveTo(CGPointMake(location.x, location.y), duration: 0.1)
            self.brush?.runAction(action)
        }
    }
    
    // ドラッグ時
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch: AnyObject = touches.first {
            let location = touch.locationInNode(self)
            let action = SKAction.moveTo(CGPointMake(location.x, location.y), duration: 0.1)
            self.brush?.runAction(action)
            
        }
    }
    
//    // 毎フレーム呼び出される
//    override func update(currentTime: NSTimeInterval) {
//    }
    
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
            point += 10

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
            point += 10
        }
    }
    
}
