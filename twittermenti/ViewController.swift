//
//  ViewController.swift
//  twittermenti
//
//  Created by Justyna Kowalkowska on 22/09/2020.
//

import UIKit
import SwifteriOS
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: SecretsKeyParser.getStringValue(forKey: "twitterConsumerKey"), consumerSecret: SecretsKeyParser.getStringValue(forKey: "twitterConsumerSecret"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prediction = try! sentimentClassifier.prediction(text: "@Apple is a terrible company")
        print(prediction.label)
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
       //     print(results)
        } failure: { (error) in
            print("There was an error with Twitter API request, \(error)")
        }
        
    }

    @IBAction func predictPressed(_ sender: UIButton) {
        
    }
    
}

