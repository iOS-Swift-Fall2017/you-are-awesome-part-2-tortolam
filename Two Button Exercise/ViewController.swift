//
//  ViewController.swift
//  Two Button Exercise
//
//  Created by Mia Tortolani on 9/4/17.
//  Copyright © 2017 Mia Tortolani. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var awesomeImage: UIImageView!
    @IBOutlet weak var soundSwitch: UISwitch!
    
    var awesomePlayer = AVAudioPlayer()
    var index = -1
    var soundNumber = -1
    var imageNumber = -1
    let numberOfImages = 6
    let numberOfSounds = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: - My Own Functions
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        // Can we load in the file soundName?
        if let sound = NSDataAsset(name: soundName) {
            // check if sound.data is a sound file
            
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                // if sound.data is not a valid audio file
                print("ERROR: data in \(soundName) couldn't be played as a sound.")
            }
        } else {
            // if reading in the NSDataAsset didn't work, tell developer/report the error
            print("ERROR: file \(soundName) didn't load.")
        }
    }
    
    func nonRepeatingRandom(lastNumber: Int, maxValue: Int) -> Int {
        var newIndex = -1
        repeat {
            newIndex = Int(arc4random_uniform(UInt32(maxValue)))
        } while lastNumber == newIndex
        return newIndex
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func soundSwitchPressed(_ sender: UISwitch) {
        if !soundSwitch.isOn && soundNumber != -1 {
                // stop playing awesome player
                awesomePlayer.stop()
        }
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        
        let messages = ["You are da Bomb",
                        "You Are Great!",
                        "You Are Amazing!",
                        "When the genius bar needs help, they call you!",
                        "You brigthen my day!",
                        "Hey good lookin, what's cookin?"]
        
        var newIndex = -1
        
        // Show messages
        index = nonRepeatingRandom(lastNumber: index, maxValue: messages.count)
        messageLabel.text = messages[index]
        
        awesomeImage.isHidden = false
        
        // Show images
        repeat {
            newIndex = Int(arc4random_uniform(UInt32(numberOfImages)))
        } while imageNumber == newIndex
        
        imageNumber = newIndex
        awesomeImage.image = UIImage(named: "image\(imageNumber)")

        if soundSwitch.isOn == true {
            // Get a random number to use in our soundName file
            repeat {
                newIndex = Int(arc4random_uniform(UInt32(numberOfSounds)))
            } while soundNumber == newIndex
            
            soundNumber = newIndex
            
            // Play a sound (NS stands for next step)
            let soundName = "sound\(soundNumber)"
            playSound(soundName: soundName, audioPlayer: &awesomePlayer)
        }
       
    }
    


}
