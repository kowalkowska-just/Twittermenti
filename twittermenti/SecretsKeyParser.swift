//
//  SecretsKeyParser.swift
//  twittermenti
//
//  Created by Justyna Kowalkowska on 24/09/2020.
//

import Foundation

struct SecretsKeyParse {
    
    static func getStringValue(forKey key: String) -> String {
        guard let path = Bundle.main.path(forResource: "SecretsKey", ofType: "plist") else {
            fatalError("Could not find value for key: \(key) in the SecretsKey.plist")
        }
        
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        
        guard let plist = try! PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else {
            fatalError("Could not read data from plist file")
        }
        
        let value = plist[key]
        return value!
        

    }
    
}

