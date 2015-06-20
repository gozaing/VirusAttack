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

class GameScene : SKScene, SKPhysicsContactDelegate {
    
    // ブラシ
    var brush:SKSpriteNode?
    // gameOverTimer
    var gameOverTimer:NSTimer?
    // gameOverTime
    let gameOverTime: NSTimeInterval = 60
    

    // viewControllerをGameSceneで保持し、menuに戻るdissmissに利用
    var GameViewController: UIViewController!

    
    var gamePaused : Bool = false {
        didSet {
            self.paused = gamePaused
        }
    }
    override var paused : Bool {
        get {
            return gamePaused
        }
        set {
            super.paused = gamePaused
        }
    }
    
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
        
        let brushTexture = SKTexture(imageNamed: "brush_blue")
        let brush = SKSpriteNode(texture: brushTexture)
        brush.position = CGPoint(x: self.size.width*0.5, y:100)
        brush.zPosition = 2
        brush.size = CGSize(width: brushTexture.size().width*0.5, height: brushTexture.size().height*0.5)
        
        // add physics
        let physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(brush.size.width/10, brush.size.height/10))
        physicsBody.dynamic = true
        physicsBody.contactTestBitMask = 0x1 << 1
        brush.physicsBody = physicsBody
        
        self.brush = brush
        self.addChild(brush)
        
        var toothCount = 3
        for (var i = 1; i<toothCount; i++) {
            
            let tooth = Tooth(objIndex:i)
            tooth.setScene(self)
            var toothPosX :CGFloat = CGFloat(100 * i)
            var toothPosY :CGFloat = 100
            
            var culcToothPosX :CGFloat = CGFloat( (Int(self.size.width) / 4) * i)
            tooth.position = CGPointMake( culcToothPosX , 420)
            self.addChild(tooth)
            
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

    
    override func didMoveToView(view: SKView) {
        
        self.gameStart()
        
    }
    
    func gameOver() {
        
        // Game Over Label
        gameoverLabel.text = "GAME OVER"
        gameoverLabel.fontSize = 40
        gameoverLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        gameoverLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        gameoverLabel.removeFromParent()
        self.addChild(gameoverLabel)
 
        // gameover状態にする
        gameOverFlg = true
        
        self.gameOverTimer?.invalidate()
        self.paused = true
        
        // ポイントラベル
        pointLabel.fontSize = 40
        pointLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        pointLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        pointLabel.removeFromParent()
        pointLabel.position = CGPoint(x: 160, y: 497)
        var pointString:String = "\(point)点"
        pointLabel.text = pointString
        self.addChild(pointLabel)

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
            let action = SKAction.moveTo(CGPointMake(location.x, location.y-50), duration: 0.1)
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
            let objIndex = (actualChildName as NSString).substringFromIndex(count(actualChildName) - 1 )
            
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
            let objIndex = (actualChildName as NSString).substringFromIndex(count(actualChildName) - 1 )
            
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
