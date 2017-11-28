//
//  viewFavorite.swift
//  morse
//
//  Created by TuyMove on 11/29/17.
//  Copyright © 2017 ZeroP. All rights reserved.
//

import UIKit

class viewFavorite: UIViewController {

    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var code: UITextView!
    var TXT_inputR = ""
    var TXT_outputR = ""
    @IBAction func flash(_ sender: Any) {
    }
    @IBAction func screen(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        text.text = morseToCode(morse:  TXT_inputR)
        code.text = morseToCode(morse:  TXT_outputR)
        // Do any additional setup after loading the view.
    }
    func morseToCode(morse:String) -> String {
        
        let reSpace = morse.replacingOccurrences(of: "-", with: "  ")
        let reOnce = reSpace.replacingOccurrences(of: "1", with: "- ")
        let reZero = reOnce.replacingOccurrences(of: "0", with: ". ")
        return reZero
    }


}
