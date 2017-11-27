//
//  morseShow.swift
//  morse
//
//  Created by TuyMove on 11/28/17.
//  Copyright © 2017 ZeroP. All rights reserved.
//

import UIKit
import AVFoundation
class morseShow: UIViewController {
    var morseCode = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 1...10{
            delay(2 * Double(i)) {
                if (i % 2) == 0 {
                    print("On")
                    self.toggleTorch(on: true)
                }else{
                    print("Off")
                    self.toggleTorch(on: false)
                }
                if i == 10 {
                    self.toggleTorch(on: false)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "morseGen") as! MorseGen
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    func delay(_ delay:Double, closure:@escaping ()->()) {
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
                    device.torchMode = .on
                    UIScreen.main.brightness = CGFloat(1.0)
                    self.view.backgroundColor = UIColor.white
                } else {
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
