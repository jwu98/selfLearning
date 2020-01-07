//
//  PlaySoundViewController.swift
//  pitchPerfect
//
//  Created by Dee Wu on 12/19/19.
//  Copyright © 2019 Dee Wu. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {

    //Outlet
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int{case snail = 0, rabbit, highPitch, lowPitch, echo, reverb }
    
    //Action
    @IBAction func playSoundButton (_ sender: UIButton) {
        
        switch (ButtonType(rawValue: sender.tag)!) {
        case .snail:
            playSound(rate: 0.3)
        case .rabbit:
            playSound(rate: 1.5)
        case .highPitch:
            playSound(pitch: 1000)
        case .lowPitch:
            playSound(pitch: -1500)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButton (_ sender: UIButton) {
        
        stopAudio()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureUI(.notPlaying)
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
