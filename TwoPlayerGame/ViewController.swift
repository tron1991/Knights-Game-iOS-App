//
//  ViewController.swift
//  TwoPlayerGame
//
//  Created by Nick on 2016-01-18.
//  Copyright © 2016 Nicholas Ivanecky. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var mainlb: UILabel!
    @IBOutlet weak var player1Hp: UILabel!
    @IBOutlet weak var player2Hp: UILabel!
    @IBOutlet weak var player1ImageView: UIImageView!
    @IBOutlet weak var player2ImageView: UIImageView!
    @IBOutlet weak var resetGameButton: UIButton!
    
    @IBOutlet weak var player1button: UIButton!
    @IBOutlet weak var player2button: UIButton!
    @IBOutlet weak var player1buttontext: UILabel!
    @IBOutlet weak var player2buttontext: UILabel!
    
    var player1: Player!
    var player2: Player!
    var attackSounds: AVAudioPlayer!
    var backgroundSounds : AVAudioPlayer?
    
    @IBAction func player1AttackButtonPress(sender: AnyObject) {
        if player2.didAttackPower(player1.playerAttackPower) {
            attackSounds?.play()
            mainlb.text = "Attacked \(player2.playerName) for \(player1.playerAttackPower)HP"
            player1Hp.text = "\(player1.player_hp)HP"
            player2Hp.text = "\(player2.player_hp)HP"
            
            player2buttontext.hidden = true
            player2button.hidden = true
            
            if player2.isAlive {
                NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "waitToAttack", userInfo: nil, repeats: false)
            } else {
                player2button.hidden = true
                player2buttontext.hidden = true
            }
           
        } else {
            mainlb.text = "Attack was unsuccessful"
        }
        
        if !player2.isAlive {
            player2ImageView.hidden = true
            player2button.hidden = true
            player2buttontext.hidden = true
            player2Hp.text = ""
            resetGameButton.hidden = false
            mainlb.text = "You killed \(player2.playerName), \(player1.playerName) has won."
        }
    }
    
    func waitToAttack() {
             player2buttontext.hidden = false
             player2button.hidden = false
    }
    
    func wait() {
        player1buttontext.hidden = false
        player1button.hidden = false
    }
    
    @IBAction func player2AttackButtonPress(sender: AnyObject) {
        if player1.didAttackPower(player2.playerAttackPower) {
            attackSounds?.play()
            mainlb.text = "Attacked \(player1.playerName) for \(player2.playerAttackPower)HP"
            player1Hp.text = "\(player1.player_hp)HP"
            player2Hp.text = "\(player2.player_hp)HP"
            
            player1buttontext.hidden = true
            player1button.hidden = true
            
            
            if player1.isAlive {
                NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "wait", userInfo: nil, repeats: false)
            } else {
                player1button.hidden = true
                player1buttontext.hidden = true
            }
            
            
        } else {
            mainlb.text = "Attack was unsuccessful"
        }
        
        if !player1.isAlive {
            player1ImageView.hidden = true
            player1button.hidden = true
            player1buttontext.hidden = true
            player1Hp.text = ""
            resetGameButton.hidden = false
            mainlb.text = "You killed \(player1.playerName), \(player2.playerName) has won."
        }
    }
    
    @IBAction func resetGame(sender: AnyObject) {
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainlb.text = "Welcome to the Knights."
        player1 = Player(player_hp: 100, playerAttackPower: 25, playerName: "looseCannon")
        player1Hp.text = "\(player1.player_hp)HP"
        generateRandomPlayer()
        player2Hp.text = "\(player2.player_hp)HP"
        
        
        if let attackSound = self.setupAudioPlayerWithFile("attack", type: "mp3") {
            self.attackSounds = attackSound
        }
        
        if let backgroundSound = self.setupAudioPlayerWithFile("background", type: "mp3") {
            self.backgroundSounds = backgroundSound
        }
        
        
        player2ImageView.hidden = false
        player2button.hidden = false
        player2buttontext.hidden = false
        player1ImageView.hidden = false
        player1button.hidden = false
        player1buttontext.hidden = false
        
        
        resetGameButton.hidden = true
        
        
        backgroundSounds?.volume = 0.3
        backgroundSounds?.play()
        
    }

    func generateRandomPlayer() {
        let rand = Int(arc4random_uniform(2))
        if rand == 0 {
            player2 = Player(player_hp: 100, playerAttackPower: 40, playerName: "WarriorLord")
        } else {
            player2 = Player(player_hp: 100, playerAttackPower: 30, playerName: "Grunt")
        }
    }
    
    //Helper Class with Sound
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        //1
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        //2
        var audioPlayer:AVAudioPlayer?
        
        // 3
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    

}

