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

    
    @IBOutlet weak var outputLal: UILabel!
    
    var btnSound : AVAudioPlayer!
    
    enum Operation:String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
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
        
        outputLal.text = "0"
        
    }

    @IBAction func numberPressed(sender:UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLal.text = runningNumber
        
    }
    
    
    @IBAction func onDividePressed(sender:AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender:AnyObject){
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender:AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender:AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender:AnyObject){
        
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClear(sender:AnyObject){
        
        currentOperation = Operation.Empty
        leftValStr = ""
        rightValStr = ""
        result = ""
        runningNumber = ""
        outputLal.text = "0"
        
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
        
    }
    
    func processOperation(operation:Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            // A user selected an operator,but then selected another operator without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if currentOperation == Operation.Add
                {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                    
                }
                
                leftValStr = result
                outputLal.text = result
                
            }
            
            currentOperation = operation
        }
        else{
            
                //This is the first time an operation has been pressed
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation =  operation
        }
        
    }
    

}

