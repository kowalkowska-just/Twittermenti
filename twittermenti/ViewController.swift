//
//  ViewController.swift
//  twittermenti
//
//  Created by Justyna Kowalkowska on 22/09/2020.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var sentimentLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: SecretsKeyParser.getStringValue(forKey: "twitterConsumerKey"), consumerSecret: SecretsKeyParser.getStringValue(forKey: "twitterConsumerSecret"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func predictPressed(_ sender: UIButton) {
        
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
           
                var tweets = [TweetSentimentClassifierInput]()
                
                for i in 0..<100 {
                    if let tweet = results[i]["full_text"].string {
                        let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                
                do {
                    let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
                    
                    var sentimentScore = 0
                    
                    for prediction in predictions {
                        let sentiment = prediction.label
                        if sentiment == "Pos" {
                            sentimentScore = sentimentScore + 1
                        } else if sentiment == "Neg" {
                            sentimentScore -= 1
                        }
                    }
                    
                    
                    if sentimentScore > 20 {
                        self.sentimentLabel.text = "😍"
                    } else if sentimentScore > 10 {
                        self.sentimentLabel.text = "😀"
                    } else if sentimentScore > 0 {
                        self.sentimentLabel.text = "🙂"
                    } else if sentimentScore == 0 {
                        self.sentimentLabel.text = "😐"
                    } else if sentimentScore > -10 {
                        self.sentimentLabel.text = "😕"
                    } else if sentimentScore > -20 {
                        self.sentimentLabel.text = "😡"
                    } else {
                        self.sentimentLabel.text = "🤮"
                    }
                    
                } catch {
                    print("There was an error with making a prediction, \(error)")
                }
                
            } failure: { (error) in
                print("There was an error with Twitter API request, \(error)")
            }
        }
    }
    
}

