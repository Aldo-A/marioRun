//
//  ViewController.swift
//  marioRun
//
//  Created by Aldo Almeida on 4/20/19.
//  Copyright © 2019 Life X. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var mario: UIImageView!
    @IBOutlet weak var bo: UIImageView!
    
    @IBAction func touchScrenn(_ sender: UIButton) {
        
        if (mario.frame.intersects(bo.frame)){
            print("Intersects")
            self.mario.frame.origin.y = -1
            sender.isEnabled=false
        }
        
        UIView.animate(withDuration: 1, animations:
            {
                self.mario.frame.origin.y-=100
            }, completion: nil)
        
        if self.mario.frame.origin.y>550 {
            self.mario.frame.origin.y=550
        }
        else
        {
            moveDown()
        }
    
        
    }
    
    private func moveDown()
    {
        UIView.animate(withDuration: 3, animations:
            {
                self.mario.frame.origin.y+=100
            }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupBG()
    }
    
    private func setupBG()
    {
        let path=URL(fileURLWithPath: Bundle.main.path(forResource: "MarioBG",ofType: "mov")!)
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


    @IBAction func PlayMusic(_ sender: Any) {
        
    }
    
}