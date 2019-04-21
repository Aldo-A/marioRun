//
//  luigiGame.swift
//  marioRun
//
//  Created by Aldo Almeida on 4/20/19.
//  Copyright © 2019 Life X. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class luigiGame: UIViewController {
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var luigi: UIImageView!
    @IBOutlet weak var bo: UIImageView!
    @IBOutlet weak var gameOver: UILabel!
    
    @IBAction func `return`(_ sender: UIButton) {
        performSegue(withIdentifier: "toStart", sender: self)
    }
    
    @IBAction func touchScrenn(_ sender: UIButton) {
        
        UIView.animate(withDuration: 1, animations:
            {
                self.luigi.frame.origin.y-=100
        }, completion: nil)
        
        if self.luigi.frame.origin.y>630 {
            self.luigi.frame.origin.y=630
        }
        else
        {
            moveDown()
        }
        
        if (self.luigi.frame.intersects(self.luigi.convert(self.bo.frame,from: bo))){
            print("Intersects")
            self.luigi.frame.origin.y = -111
            sender.isEnabled = false
            gameOver.text="GAME OVER"
        }
        
        
    }
    
    private func moveDown()
    {
        UIView.animate(withDuration: 3, animations:
            {
                self.luigi.frame.origin.y+=50
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
