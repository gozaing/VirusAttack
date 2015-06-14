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
let reloadIcon = UIButton(frame: CGRectMake(150, 400, 200, 50))

class GameScene : SKScene, SKPhysicsContactDelegate {
        
    // ブラシ
    var brush:SKSpriteNode?
    // timer
    var timer:NSTimer?
    // gameOverTimer
    var gameOverTimer:NSTimer?
    
    func gameStart() {
        
        gameOverFlg = false
        point = 0

        self.brush = nil
        self.timer = nil
        self.gameOverTimer = nil
        
        // gameOverTimer start
        self.gameOverTimer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: "gameOver", userInfo: nil, repeats: false)
        
        // ポイントラベル
        pointLabel.text = "0点"
        pointLabel.fontSize = 40
        pointLabel.fontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        pointLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        pointLabel.removeFromParent()
        self.addChild(pointLabel)
        pointLabel.position = CGPoint(x: 160, y: 497)
        
        
        // 衝突プロトコルの発生
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        let brushTexture = SKTexture(imageNamed: "toothbrush")
        let brush = SKSpriteNode(texture: brushTexture)
        brush.position = CGPoint(x: self.size.width*0.5, y:100)
        brush.size = CGSize(width: brushTexture.size().width*0.5, height: brushTexture.size().height*0.5)
        brush.physicsBody = SKPhysicsBody(texture: brushTexture, size: brush.size)
        brush.physicsBody?.dynamic = false
        
        // add physics
        let physicsBody = SKPhysicsBody(rectangleOfSize: brush.frame.size)
        physicsBody.dynamic = true
        physicsBody.contactTestBitMask = 0x1 << 1
        brush.physicsBody = physicsBody
        
        self.brush = brush
        self.addChild(brush)
        
        // add tooth
        // TODO:background.sizeからtoothCountで算出する
        
        var toothCount = 3
        for (var i = 1; i<toothCount; i++) {
            
            let tooth = Tooth(objIndex:i)
            tooth.setScene(self)
            var toothPosX :CGFloat = CGFloat(100 * i)
            var toothPosY :CGFloat = 100
            
            var culcToothPosX :CGFloat = CGFloat( (Int(self.size.width) / 4) * i)
            
            tooth.position = CGPointMake( culcToothPosX , 420)
            //            tooth.position = CGPointMake( toothPosX , 420)
            
            self.addChild(tooth)
            
        }

    }
    
    func reloadGame() {
        
        var Nodes : [SKNode]
        
        NSLog("reloadGame-1")
        for Node : AnyObject in self.children{
            
            if (Node as! SKNode).name == nil  {
                println("name is nil")
                Node.removeFromParent()
            }
            else{
                if Node.name == "background" {
                    //Nodes.append(Node as! SKNode)
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
        
        // ボタンを生成
        let reloadIcon = UIButton(frame: CGRectMake(150, 400, 200, 50))
        reloadIcon.setImage(UIImage(named: "reload"), forState: .Normal)
        reloadIcon.addTarget(self, action: "clickReload:", forControlEvents: .TouchUpInside)
        reloadIcon.removeFromSuperview()
        self.view!.addSubview(reloadIcon)
 
        // gameover状態にする
        gameOverFlg = true
        
        self.gameOverTimer?.invalidate()
        self.paused = true
        
        homeIcon.alpha = CGFloat(1)
        
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
            let objIndex = (actualChildName as NSString).substringFromIndex(count(actualChildName) - 1 )
            
            var parentTooth = self.childNodeWithName("tooth-" + objIndex) as! Tooth
            var virus:Virus?
            virus = parentTooth.childNodeWithName("virus-" + objIndex) as? Virus
            virus?.timer.invalidate()
                
            // parent run Action
            parentTooth.winAction()

            targetNode!.removeFromParent()
            
            // 加算
            point += 10
            var pointString:String = "\(point)点"
            pointLabel.text = pointString
            
            

        }else if (contact.bodyB.node == self.brush){

            var targetNode:SKNode? = contact.bodyA.node
            
            let actualChildName = targetNode?.name ?? "Undefined"
            let objIndex = (actualChildName as NSString).substringFromIndex(count(actualChildName) - 1 )
            
            var parentTooth = self.childNodeWithName("tooth-" + objIndex) as! Tooth
            var virus:Virus?
            virus = parentTooth.childNodeWithName("virus-" + objIndex) as? Virus
            virus?.timer.invalidate()
            
            // parent run Action
            parentTooth.winAction()
            
            targetNode!.removeFromParent()
            
            // 加算
            point += 10
            var pointString:String = "\(point)点"
            pointLabel.text = pointString

        }
    }
    
}
