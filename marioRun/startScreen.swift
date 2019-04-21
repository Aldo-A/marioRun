//
//  startScreen.swift
//  marioRun
//
//  Created by Aldo Almeida on 4/20/19.
//  Copyright © 2019 Life X. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class startScreen: UIViewController {

    @IBOutlet weak var viewBG: UIView!
    
    @IBAction func selectMario(_ sender: UIButton) {
        performSegue(withIdentifier: "toGame", sender: self)
    }
    
    @IBAction func selectBowser(_ sender: UIButton) {
        performSegue(withIdentifier: "bowserGame", sender: self)
    }
    @IBAction func selectLuigi(_ sender: UIButton) {
        performSegue(withIdentifier: "luigiGame", sender: self)
    }
    @IBAction func selectMushroom(_ sender: UIButton) {
        performSegue(withIdentifier: "mushGame", sender: self)
    }
    @IBAction func selectWaluigi(_ sender: UIButton) {
        performSegue(withIdentifier: "warioGame", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBG()

        // Do any additional setup after loading the view.
    }
    
    private func setupBG()
    {
        let path=URL(fileURLWithPath: Bundle.main.path(forResource: "bg",ofType: "mov")!)
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
