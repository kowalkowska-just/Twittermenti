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
    
    let swifter = Swifter(consumerKey: SecretsKeyParser.getStringValue(forKey: "twitterConsumerKey"), consumerSecret: SecretsKeyParser.getStringValue(forKey: "twitterConsumerSecret"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
            print(results)
        } failure: { (error) in
            print("There was an error with Twitter API request, \(error)")
        }
        
    }

    @IBAction func predictPressed(_ sender: UIButton) {
        
    }
    
}

