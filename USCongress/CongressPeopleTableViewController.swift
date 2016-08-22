//
//  CongressPeopleTableViewController.swift
//  USCongress
//
//  Created by Julius D. Higiro on 8/10/16.
//  Copyright © 2016 Julius D. Higiro. All rights reserved.
//

import UIKit

class CongressPeopleTableViewController: UITableViewController {
    
    var senPoliticianListToDisplay:[Politician]?
    var repPoliticianListToDisplay:[Politician]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.layoutMargins = UIEdgeInsetsZero
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var politicoListSize:Int = 0
        if section == 0 {
            if let actualSenPolitician = senPoliticianListToDisplay {
                politicoListSize = actualSenPolitician.count
            } else {
                politicoListSize = 0
            }
        } else {
            if let actualRepPolitician = repPoliticianListToDisplay {
                politicoListSize = actualRepPolitician.count
            } else {
                politicoListSize = 0
            }
        }
        return politicoListSize
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("toTableViewCell", forIndexPath: indexPath) as! CongressTableViewCell
 
        var currentPolToDisplay:Politician = Politician()
        if indexPath.section == 0 {
            if let actualSenPolitician = senPoliticianListToDisplay {
                currentPolToDisplay = actualSenPolitician[indexPath.row]
            } else {
                currentPolToDisplay = Politician()
            }
        } else {
            if let actualRepPolitician = repPoliticianListToDisplay {
                currentPolToDisplay = actualRepPolitician[indexPath.row]
            } else {
                currentPolToDisplay = Politician()
            }
        }
        
        if let actualNameLabel = cell.nameLabel {
            
            actualNameLabel.text = currentPolToDisplay.firstName + " " + currentPolToDisplay.lastName
        }
        
        if let actualStateLabel = cell.stateLabel {
            var district:Int = 0
            if(currentPolToDisplay.chamber == "senate") {
                actualStateLabel.text = "State: " + currentPolToDisplay.state
            } else {
                district = currentPolToDisplay.district
                actualStateLabel.text = "State: " + currentPolToDisplay.state + " District: " + String(district)
            }
        }
        
        if let actualPartyLabel = cell.partyLabel {
            actualPartyLabel.text = "Party: " + currentPolToDisplay.party
        }

        if let actualTermStartLabel = cell.termStartLabel {
            actualTermStartLabel.text = "Term Start: " + currentPolToDisplay.termStart         }

        if let actualTermEndLabel = cell.termEndLabel {
            actualTermEndLabel.text = "Term End: " + currentPolToDisplay.termEnd
        }
 
        if let actualImageView = cell.officialPicture {
            if currentPolToDisplay.bioGuideId != "" {
                let api:String = "https://theunitedstates.io/images/congress/225x275/"+currentPolToDisplay.bioGuideId+".jpg"
                // Create an NSURL object
                let url:NSURL? = NSURL(string: api)
                // Create an NSURLRequest
                let imageRequest:NSURLRequest = NSURLRequest(URL: url!)
                // Create an NSURLSession
                let session:NSURLSession = NSURLSession.sharedSession()
                // Create an NSURLSessionDataTask
                let dataTask:NSURLSessionDataTask = session.dataTaskWithRequest(imageRequest, completionHandler: { (data, response, error) -> Void in
   
                    // Fire off that code to execute on the main thread
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        // When the image has been downloaded, use that data to create an UIImage object and assign it into the imageview
                        actualImageView.image = UIImage(data: data!)
                        
                    })
                    
                })
                dataTask.resume()
            }
            
        }
        
        // Set insets to zero
        cell.layoutMargins = UIEdgeInsetsZero
        // Return the cell
        return cell
    }
 
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTitle:UILabel = UILabel()
        if section == 0 {
            headerTitle.text = "UNITED STATES SENATORS"
        } else {
            headerTitle.text = "UNITED STATES REPRESENTATIVES"
        }
        headerTitle.textAlignment = NSTextAlignment.Center
        return headerTitle
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
