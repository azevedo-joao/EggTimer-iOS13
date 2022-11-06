//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
//    let softTime: Int = 5
//    let mediumTime: Int = 8
//    let hardTime: Int = 12
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var cancelButton: UIButton!
    var player: AVAudioPlayer!
    
    //let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720]
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    //damit es nur einen Timer gibt
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
        cancelButton.isHidden = true
    }
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //startet den Timer neu
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressView.progress = 0.0
        secondsPassed = 0
        cancelButton.isHidden = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        timer.invalidate()
        showMessage(title: "Cancelled", message: "Your timer was cancelled")
        progressView.progress = 0.0
        cancelButton.isHidden = true
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressView.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            cancelButton.isHidden = true
            timer.invalidate()
            showMessage(title: "Done", message: "Your eggs are done!")
            playAlarm()
        }
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    func showMessage(title: String, message: String ) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: {(action) -> Void in})
        dialogMessage.addAction(okButton)
        self.present(dialogMessage, animated: true, completion: nil)
    }
}
    

