//
//  MorseGen.swift
//  morse
//
//  Created by TuyMove on 11/27/17.
//  Copyright © 2017 ZeroP. All rights reserved.
//

import UIKit
import Foundation
extension String  {
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
}
class MorseGen: UIViewController {
    let eng : [String: String] = [ "a" : "01", "b" : "1000", "c" : "1010", "d" : "100", "e" : "0", "f" : "0010", "g" : "110", "h" : "0000", "i" : "00", "j" : "0111", "k" : "101", "l" : "0100", "m" : "11", "n" : "10", "o" : "111", "p" : "0110", "q" : "1101", "r" : "010", "s" : "000", "t" : "1", "u" : "001", "v" : "0001", "w" : "011", "x" : "1001", "y" : "1011", "z" : "1100"," ":"-"]
    let thai : [String : String] = [ "ก" : "110", "ข" : "1010", "ฃ" : "1010", "ค" : "101", "ฅ" : "101", "ฆ" : "101", "ง" : "10110", "จ" : "10010", "ฉ" : "1111", "ช" : "1001", "ฌ" : "1001", "ซ" : "1100", "ญ" : "0111", "ด" : "100", "ฎ" : "100", "ต" : "1", "ฏ" : "1", "ถ" : "10100", "ฐ" : "10100", "ท" : "10011", "ธ" : "10011", "ฑ" : "10011", "ฒ" : "10011", "น" : "10", "ณ" : "10", "บ" : "1000", "ป" : "0110", "ผ" : "1101", "ฝ" : "10101", "พ" : "01100", "ภ" : "01100", "ฟ" : "0010", "ม" : "11", "ย" : "1011", "ร" : "010", "ล" : "0100", "ฬ" : "0100", "ว" : "011", "ศ" : "000", "ษ" : "000", "ส" : "000", "ห" : "0000", "อ" : "10001", "ฮ" : "11011", "ฤ" : "01011", "ฤา" : "01011", "ะ" : "01000", "า" : "01", "ิ" : "00100", "ี" : "00", "ึ" : "00110", "ื" : "0011", "ุ" : "00101", "ู" : "1110", "เ" : "0", "แ" : "0101", "ไ" : "01001", "ใ" : "01001", "โ" : "111", "ำ" : "00010", "่" : "001", "้" : "0001", "๊" : "11000", "๋" : "01010","ั" : "01101", "็" : "11100", "์" : "11001", "ๆ" : "10111", "ฯ" : "11010", "ฯลฯ" : "11101"]
    let num : [String : String] = ["1" : "01111", "2" : "00111", "3" : "00011", "4" : "00001", "5" : "00000", "6" : "10000", "7" : "11000", "8" : "11100", "9" : "11110", "0" : "11111"," ":"-"]

    @IBOutlet weak var TXT_output: UITextView!
    @IBOutlet weak var morseLang: UISegmentedControl!
    @IBOutlet weak var TXT_input: UITextField!
    var TXT_inputR = ""
    var TXT_outputR = ""
    var morse : String = ""
    @IBAction func Flash(_ sender: Any) {
        
    }
    @IBAction func addFav(_ sender: Any) {
        if morseLang.selectedSegmentIndex == 0{
            //Thai
            morse = textToMorse(lang: false, rawText: TXT_input.text!.trimmingCharacters(in: .whitespaces))
        }else{
            //Eng
            morse = textToMorse(lang: true, rawText: TXT_input.text!.trimmingCharacters(in: .whitespaces))
        }
        let DB = SQLiteDB.shared
        DB.openDB()
        let str:String = "INSERT INTO favorite(text,code) VALUES('\(TXT_input.text!)','\(morse)')"
        let data = DB.query(sql: str)
        print(data)
    }
    
    @IBAction func Screen(_ sender: Any) {
        if morseLang.selectedSegmentIndex == 0{
            //Thai
            morse = textToMorse(lang: false, rawText: TXT_input.text!.trimmingCharacters(in: .whitespaces))
        }else{
            //Eng
            morse = textToMorse(lang: true, rawText: TXT_input.text!.trimmingCharacters(in: .whitespaces))
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "morseShow") as! morseShow
        vc.morseCode = morse
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func toMorse(_ sender: Any) {
        
        if morseLang.selectedSegmentIndex == 0{
            //Thai
            morse = textToMorse(lang: false, rawText: TXT_input.text!.trimmingCharacters(in: .whitespaces))
        }else{
            //Eng
            morse = textToMorse(lang: true, rawText: TXT_input.text!.trimmingCharacters(in: .whitespaces))
        }
        TXT_output.text = morseToCode(morse: morse)
    }
    
    @IBAction func clearTxT(_ sender: Any) {
        TXT_input.text = ""
        TXT_output.text = ""
    }
    
    func morseToCode(morse:String) -> String {
        
        let reSpace = morse.replacingOccurrences(of: "-", with: "  ")
        let reOnce = reSpace.replacingOccurrences(of: "1", with: "- ")
        let reZero = reOnce.replacingOccurrences(of: "0", with: ". ")
        return reZero
    }
    
    func textToMorse(lang:Bool,rawText:String) -> String {
        var morse : String = ""
        if lang{
            for char in rawText.lowercased() {
                if (eng["\(char)"] != nil){
                    morse += "-\(eng["\(char)"]!)";
                }else{
                    morse += "-\(num["\(char)"]!)";
                }
            }
        }else{
            var dataenc = rawText.data(using: String.Encoding.nonLossyASCII)
            var thaiText = String(data: dataenc!, encoding: String.Encoding.utf8)
            var thaiText2 = thaiText!.components(separatedBy: "\\")
            print(thaiText2)
            thaiText2.remove(at: 0)
            for charEnc in thaiText2 {
                var encodevalue = "\\\(charEnc)"
                var datadec  = encodevalue.data(using: String.Encoding.utf8)
                var char = String(data: datadec!, encoding: String.Encoding.nonLossyASCII)
                if (thai[char!] != nil){
                    morse += "-\(thai["\(char!)"]!)"
                }else{
                    morse += "-\(num["\(char!)"]!)"
                }
            }
        }
        return morse
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TXT_input.text = TXT_inputR
        TXT_output.text = TXT_outputR
        self.reloadInputViews()
        
    }


}
