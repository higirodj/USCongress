//
//  ViewController.swift
//  USCongress
//
//  Created by Julius D. Higiro on 8/10/16.
//  Copyright © 2016 Julius D. Higiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CongressModelDelegate {
    
    @IBOutlet weak var inputZipCode: UITextField!
    @IBOutlet weak var search: SearchButton!
    let congressModel:CongressModel = CongressModel()
    var senPoliticoProfileList:[Politician] = [Politician]()
    var repPoliticoProfileList:[Politician] = [Politician]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        search.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        // Set itself as the delegate for the congressModel
        self.congressModel.delegate = self
    }
    
    func isValidZipCode(candidate: String) -> Bool {
        let zipCodeRegex = "^\\d{5}$"
        
        return NSPredicate(format: "SELF MATCHES %@", zipCodeRegex).evaluateWithObject(candidate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Removes the key board when the user touches anywhere in the view
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.inputZipCode.resignFirstResponder()
    }
    
    // Once the button is pressed the data input is validated as a proper zip code value
    // If the input value is invalid, then an alert message prompts the user to enter a valid
    // zip code
    func buttonAction() {
        if (isValidZipCode(self.inputZipCode.text!)) {
            // Fire off request to download and parse the list of politicians
            self.congressModel.getPoliticianProfiles(self.inputZipCode.text!)
            // TODO: Animation to display while loading data onto table view
            // Trigger the segue to go the table view scene
            self.performSegueWithIdentifier("toTableViewSegue", sender: self)
        } else {
            let alert:UIAlertController = UIAlertController(title: "Invalid zip code", message: "Enter a valid zip code", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    func senPoliticianListReady(senPolitician:[Politician]) {
        self.senPoliticoProfileList = senPolitician
    }
    
    func repPoliticianListReady(repPolitician:[Politician]) {
        self.repPoliticoProfileList = repPolitician
    }
    
    
    // Data is sent to the CongressPeopleTableViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "toTableViewSegue") {
            let nextScene:CongressPeopleTableViewController = segue.destinationViewController as! CongressPeopleTableViewController
            // Pass the list of politicians to the next scene
            nextScene.senPoliticianListToDisplay = self.senPoliticoProfileList
            nextScene.repPoliticianListToDisplay = self.repPoliticoProfileList
        }
    }
    
}

