//
//  bowserStart.swift
//  marioRun
//
//  Created by Aldo Almeida on 4/20/19.
//  Copyright © 2019 Life X. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SpriteKit

class bowserStart: UIViewController {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var bowser: UIImageView!
    @IBOutlet weak var gameOver: UILabel!
    @IBOutlet weak var bo: UIImageView!
    
    @IBAction func `return`(_ sender: UIButton) {
        performSegue(withIdentifier: "toStart", sender: self)
    }
    
    @IBAction func touchScrenn(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1, animations:
            {
                self.bowser.frame.origin.y-=100
        }, completion: nil)
        
        if self.bowser.frame.origin.y>630 {
            self.bowser.frame.origin.y=630
        }
        else
        {
            moveDown()
        }
        
        if (self.bowser.frame.intersects(self.bowser.convert(self.bo.frame,from: bo))){
            print("Intersects")
            self.bowser.frame.origin.y = -111
            sender.isEnabled = false
            gameOver.text="GAME OVER"
        }
    }
    
    private func moveDown()
    {
        UIView.animate(withDuration: 3, animations:
            {
                self.bowser.frame.origin.y+=50
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupBG()
    }
    
    private func setupBG()
    {
        let path=URL(fileURLWithPath: Bundle.main.path(forResource: "MarioBG2",ofType: "mov")!)
        let player=AVPlayer(url:path)
        
        let newLayer=AVPlayerLayer(player:player)
        newLayer.frame=self.viewBG.frame
        self.viewBG.layer.addSublayer(newLayer)
        newLayer.videoGravity=AVLayerVideoGravity.resizeAspectFill
        player.play()
        player.actionAtItemEnd=AVPlayer.ActionAtItemEnd.none
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
    }
    
    @objc func videoDidPlayToEnd(_ notification: Notification)
    {
        let player:AVPlayerItem=notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero)
    }
    
    
}

//class GameScene:SkScene, SKPhysicsContactDelegate{
//
//    func didMoveToView(view:SkView){
//
//        self.physicsWorld.contactDelegate = self
//        createEnemies()
//    }
//    deinit{
//        print("deinit called")
//    }
//    func randomBetweenNumbers(firstNum:CGFloat, secondNum:CGFloat) -> CGFloat{
//        return CGFloat(arc4random()) / CGFloat(UINT32_MAX)* abs(firstNum - secondNum) + min(firstNum, secondNum)
//    }
//    func randomPointBetween(start:CGPoint, end: CGPoint) ->CGPoint{
//        return CGPoint(x: randomBetweenNumbers(start.x, secondNum: end.x), y: randomBetweenNumbers(start.y, secondNum: end.y))
//    }
//    func createEnemies(){
//        let wait = SKAction .waitForDuration(0.5, withRange:0.2)
//
//        weak var weakSelf = self
//        let spawn = SKAction.runBlock({
//
//            var random = arc4random() % 4 + 1
//            var position = CGPoint()
//            var moveTo = CGPoint()
//            var offSet:CGFloat = 40
//
//            println(random)
//
//            switch random{
//
//            case 1:
//                position = weakSelf!.randomPointBetween(CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: weakSelf!.frame.height))
//                moveTo = weakSelf!.randomPointBetween(CGPoint(x:0, y:0), end: CGPoint(x:0, y: weakSelf!.frame.height))
//                break
//
//            default:
//                break
//            }
//            weakSelf!.spawnEnemyAtPosition(position, moveTo: moveTo)
//    })
//        let spawning = SKAction.sequence([wait,spawn])
//        self.runAction(SKAction.repeatActionForever(spawning), withKey:"spawning")
//}
//    func spawnEnemyAtPosition(position:CGPoint, moveTo:CGPoint){
//
//        let enemy = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: 40, height: 40))
//
//
//        enemy.position = position
//        enemy.physicsBody = SKPhysicsBody(rectangleOfSize: enemy.size)
//        enemy.physicsBody?.affectedByGravity = false
//        enemy.physicsBody?.dynamic = true
//        enemy.physicsBody?.collisionBitMask = 0 // no collisions
//        //Here you can randomize the value of duration parameter to change the speed of a node
//        let move = SKAction.moveTo(moveTo,duration: 2.5)
//        let remove = SKAction.removeFromParent()
//        enemy.runAction(SKAction.sequence([move, remove]))
//
//
//        self.addChild(enemy)
//
//    }
//
//
//    func didBeginContact(contact: SKPhysicsContact) {
//
//}
