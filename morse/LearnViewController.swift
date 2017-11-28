//
//  learnViewController.swift
//  morse
//
//  Created by TuyMove on 11/29/17.
//  Copyright © 2017 ZeroP. All rights reserved.
//

import UIKit

class learnViewController: UIViewController {


    @IBOutlet weak var offline: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myFile = Bundle.main.path(forResource: "learn", ofType: "html")
        let urlWeb = URL(fileURLWithPath: myFile!)
        let requestURL = NSURLRequest(url: urlWeb as! URL)
        offline.loadRequest(requestURL as URLRequest)
        // Do any additional setup after loading the view.
    }


}
