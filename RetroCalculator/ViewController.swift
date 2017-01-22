//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Header-Develop on 1/22/2560 BE.
//  Copyright © 2560 Header-Development. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var btnSound : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        }catch let _error as NSError{
            print(_error.debugDescription)
        }
        
    }

    @IBAction func numberPressed(sender:UIButton){
        playSound()
    }
    
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
    }
    

}

