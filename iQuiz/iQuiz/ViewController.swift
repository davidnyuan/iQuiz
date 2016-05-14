//
//  ViewController.swift
//  iQuiz
//
//  Created by David Yuan on 5/5/16.
//  Copyright © 2016 David Yuan. All rights reserved.
//

import UIKit

struct URLToGo {
    static var targetURL = "http://tednewardsandbox.site44.com/questions.json"
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let inputData = fromJson()
    
    @IBOutlet weak var tableView: UITableView!
    
    func dismissAlert(alert: UIAlertAction!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func settings(sender: AnyObject) {
        let alertController : UIAlertController = UIAlertController(title: "Alert!", message: "Settings go here.", preferredStyle: .Alert)
        let okAction : UIAlertAction = UIAlertAction(title: "Okay", style: .Default, handler: dismissAlert)
        
        alertController.addAction(okAction)
        
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter URL to retrieve information."
        }
        
        let retrieveAction : UIAlertAction = UIAlertAction(title: "Check Now", style: .Cancel, handler: {[weak self]
            (paramAction:UIAlertAction!) in
            if let textFields = alertController.textFields {
                let theTextFields = textFields as [UITextField]
                let enteredText = theTextFields[0].text
                if enteredText != nil {
                    URLToGo.targetURL = enteredText!
                } else {
                    URLToGo.targetURL = "http://tednewardsandbox.site44.cÇom/questions.json"
                }
                self!.tableView.reloadData()
            }
            })
        
        alertController.addAction(retrieveAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    var subjects : [String] = []
    var subtitle : [String] = []
    var images = [UIImage(named: "pi"), UIImage(named: "ROcket"), UIImage(named: "DNA")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.inputData.HTTPRequest {
            
            self.subjects = self.inputData.names
            self.subtitle = self.inputData.descrs
            
            self.tableView.reloadData()
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjects.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.subject.text = subjects[indexPath.row]
        cell.subtitle.text = subtitle[indexPath.row]
        cell.photo.image = images[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let SecondVC = self.storyboard?.instantiateViewControllerWithIdentifier("QuestionC") as! QuestionController
        SecondVC.subjectTitle = subjects[indexPath.row]
        SecondVC.topic = inputData.topic[indexPath.row]
        SecondVC.totalQuestions = inputData.topic[indexPath.row].questions.count
        self.presentViewController(SecondVC, animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
