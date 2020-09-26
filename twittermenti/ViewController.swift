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
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended) { (results, metadata) in
       
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
                
                print(sentimentScore)
                
                if sentimentScore > 0 {
                    print("Positive")
                } else if sentimentScore == 0 {
                    print("Neutral")
                } else if sentimentScore < 0 {
                    print("Negative")
                }
                
            
                
                
            } catch {
                print("There was an error with making a prediction, \(error)")
            }
            
        } failure: { (error) in
            print("There was an error with Twitter API request, \(error)")
        }
        
    }

    @IBAction func predictPressed(_ sender: UIButton) {
        
    }
    
}

