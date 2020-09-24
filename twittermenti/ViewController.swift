//
//  ViewController.swift
//  twittermenti
//
//  Created by Justyna Kowalkowska on 22/09/2020.
//

import UIKit
import SwifteriOS

class ViewController: UIViewController {

    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let swifter = Swifter(consumerKey: SecretsKeyParse.getStringValue(forKey: "twitterConsumerKey"), consumerSecret: SecretsKeyParse.getStringValue(forKey: "twitterConsumerSecret"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func predictPressed(_ sender: UIButton) {
        
    }
    
}

