//
//  morseShow.swift
//  morse
//
//  Created by TuyMove on 11/28/17.
//  Copyright © 2017 ZeroP. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class morseShow: UIViewController {
    var morseCode = ""
    var morseDelay: Double = 0
    let stdDelay : [String: Double] = [ "dot" : 1, "dash" : 3, "inEle" : 1, "shoGap" : 3, "medGap" : 7]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(morseCode)
        var morse = morseCode.components(separatedBy: "-")
        print(morse)
        morse.remove(at: 0)
        
        for (index1,chars) in morse.enumerated(){
            print(chars)
            for (index2,char) in chars.enumerated(){
                if char == "0"{
                    //play
                    delay(morseDelay) {
                        print("On 0.5 Sec")
                        self.toggleTorch(on: true)
                    }
                    morseDelay += stdDelay["dot"]!
                    //pause
                    delay(morseDelay) {
                        print("Off 0.5 Sec")
                        self.toggleTorch(on: false)
                    }
                    morseDelay += stdDelay["inEle"]!
                }
                if char == "1"{
                    //play
                    delay(morseDelay) {
                        print("On 1.5 Sec")
                        self.toggleTorch(on: true)
                    }
                    morseDelay += stdDelay["dash"]!
                    //pause
                    delay(morseDelay) {
                        print("Off 0.5 Sec")
                        self.toggleTorch(on: false)
                    }
                    morseDelay += stdDelay["inEle"]!
                }

                if index1 == (morse.count - 1)&&index2==(chars.count - 1){
                    delay(morseDelay) {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "morseGen") as! MorseGen
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
            morseDelay += stdDelay["medGap"]!
        }
        
//        for i in 1...morseCode.count{
//            delay(2 * Double(i)) {
//                if (i % 2) == 0 {
//                    print("On")
//                    self.toggleTorch(on: true)
//                }else{
//                    print("Off")
//                    self.toggleTorch(on: false)
//                }
//                if i == 10 {
//                    self.toggleTorch(on: false)
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "morseGen") as! MorseGen
//                    self.present(vc, animated: true, completion: nil)
//                }
//            }
//        }
        
        
        // Do any additional setup after loading the view.
    }
    func delay(_ delay:Double, closure:@escaping ()->()) {
        print("Now delay \(morseDelay)")
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video)
            else {return}
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
//                    device.torchMode = .on
                    UIScreen.main.brightness = CGFloat(1.0)
                    self.view.backgroundColor = UIColor.white
                } else {
//
                    device.torchMode = .off
                    UIScreen.main.brightness = CGFloat(0.1)
                    self.view.backgroundColor = UIColor.black
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
