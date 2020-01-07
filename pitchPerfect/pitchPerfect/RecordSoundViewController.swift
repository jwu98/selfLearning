//
//  RecordSoundViewController.swift
//  pitchPerfect
//
//  Created by Dee Wu on 12/16/19.
//  Copyright © 2019 Dee Wu. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Disabling stop button
        stopRecordingButton.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    //MARK: Recording Button
    @IBAction func recordAudio(_ sender: Any) {
              
        setRecordingStatus("Recording", true, false, UIColor.red)
        
        //Setup for Audio file
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default,
                                 options: AVAudioSession.CategoryOptions.defaultToSpeaker)

        
        //Start recording
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    //MARK: Stop Recording Button
    @IBAction func stopRecording(_ sender: Any) {
        
        setRecordingStatus("Tap to Record", false, true)
        
        //stop recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    //MARK: Audio Recorder Delegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else {
            //something is wrong
            print("Recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundVC = segue.destination as! PlaySoundViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
        else {
            print("Something is wrong, Stopping...")
            exit(1)
        }
    }
    
    //MARK: SetRecordingStatus
    func setRecordingStatus (_ text: String, _ stopButtonStatus: Bool, _ recordButtonStatus: Bool, _ color: UIColor = UIColor.black){
        recordingLabel.text = text
        recordingLabel.textColor = color
        stopRecordingButton.isEnabled = stopButtonStatus
        recordButton.isEnabled = recordButtonStatus

    }
}

