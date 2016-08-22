//
//  Congress.swift
//  USCongress
//
//  Created by Julius D. Higiro on 8/10/16.
//  Copyright © 2016 Julius D. Higiro. All rights reserved.
//

import UIKit

protocol CongressModelDelegate {
    func senPoliticianListReady(politician:[Politician])
    func repPoliticianListReady(politician:[Politician])
}

class CongressModel: NSObject {
    
    var delegate:CongressModelDelegate?
    
    // Build list of sen. and rep. profiles and store in array
    func getPoliticianProfiles(zipcode:String) {
        
        var senProfiles:[Politician] = [Politician]()
        var repProfiles:[Politician] = [Politician]()
        // Get JSON array of dictionaries
        let jsonObjects:NSDictionary = self.getRemoteJSONFile(zipcode)
        
        // Iterate through the array of dictionaries and grab the senators
        for index in 0 ..< jsonObjects["results"]!.count {
            let jsonDictionary:NSDictionary = (jsonObjects["results"]?[index])! as! NSDictionary
            // Create a politician object
            let senPol:Politician = Politician()
            if (jsonDictionary["chamber"]as! String == "senate") {
                // Assign the values associated with each key value pair to the politician object
                senPol.firstName = jsonDictionary["first_name"]as! String
                senPol.lastName = jsonDictionary["last_name"]as! String
                senPol.bioGuideId = jsonDictionary["bioguide_id"]as! String
                senPol.voteSmartId = jsonDictionary["votesmart_id"]as! Int
                senPol.title = jsonDictionary["title"]as! String
                senPol.state = jsonDictionary["state"]as! String
                senPol.party = jsonDictionary["party"]as! String
                senPol.chamber = jsonDictionary["chamber"]as! String
                senPol.birthDay = jsonDictionary["birthday"]as! String
                senPol.termStart = jsonDictionary["term_start"]as! String
                senPol.termEnd = jsonDictionary["term_end"]as! String
                // Add a senator object to the array of politician profiles
                senProfiles.append(senPol)
            }
        }
        
        // Iterate through the array of dictionaries and grab the representatives
        for index in 0 ..< jsonObjects["results"]!.count {
            let jsonDictionary:NSDictionary = (jsonObjects["results"]?[index])! as! NSDictionary
            // Create a senator object
            let repPol:Politician = Politician()
            if (jsonDictionary["chamber"]as! String == "house") {
                // Assign the values associated with each key value pair to the senator object
                repPol.firstName = jsonDictionary["first_name"]as! String
                repPol.lastName = jsonDictionary["last_name"]as! String
                repPol.bioGuideId = jsonDictionary["bioguide_id"]as! String
                repPol.voteSmartId = jsonDictionary["votesmart_id"]as! Int
                repPol.title = jsonDictionary["title"]as! String
                repPol.state = jsonDictionary["state"]as! String
                repPol.party = jsonDictionary["party"]as! String
                repPol.chamber = jsonDictionary["chamber"]as! String
                repPol.district = jsonDictionary["district"]as! Int
                repPol.birthDay = jsonDictionary["birthday"]as! String
                repPol.termStart = jsonDictionary["term_start"]as! String
                repPol.termEnd = jsonDictionary["term_end"]as! String
                // Add a representative profile to the array of representative profiles
                repProfiles.append(repPol)
            }
        }

        if let actualDelegate = self.delegate {
            // This means there is an obj assigned to the delegate property
            actualDelegate.senPoliticianListReady(senProfiles)
            actualDelegate.repPoliticianListReady(repProfiles)
        }
    }
    
    func getRemoteJSONFile(zipcode:String) -> NSDictionary {
        let api:String = "https://congress.api.sunlightfoundation.com/legislators/locate?zip="+zipcode+"&apikey=35051e76959947d9b9624304425252c0"
        let remoteUrl:NSURL? = NSURL(string: api)
        if let actualRemoteUrl = remoteUrl {
            let jsonData:NSData? = NSData(contentsOfURL: actualRemoteUrl)
            if let actualJsonData = jsonData {
                // NSData exists, use the NSJSONSerialization classes to parse the data
                // and create the dictionary
                do {
                    let jsonDictionary:NSDictionary = try NSJSONSerialization.JSONObjectWithData(actualJsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    return jsonDictionary;
                } catch let error as NSError {
                    // There was an error parsing the json file
                    print("Error processing json data: \(error.localizedDescription)")
                }
            } else {
                // NSData doesn't exist
            }
        }
            return NSDictionary()
    }
    
}
