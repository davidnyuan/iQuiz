//
//  SummaryController.swift
//  iQuiz
//
//  Created by David Yuan on 5/14/16.
//  Copyright © 2016 David Yuan. All rights reserved.
//

import Foundation
import UIKit

class SummaryController: UIViewController {

    @IBOutlet weak var Subject: UILabel!
    var subjectTitle = ""
    @IBOutlet weak var Score: UILabel!
    var right = 0
    var total = 0
    @IBOutlet weak var Comment: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Subject!.text! = subjectTitle
        Score!.text! = "You got \(right) questions right out of \(total)!"
        if right == total{
            self.Comment!.text! = "Perfect!"
        } else if right > (total/2) {
            self.Comment!.text! = "Close but not quite!"
        } else if right > 0 {
            self.Comment!.text! = "Keep Trying!"
        } else {
            self.Comment!.text! = "Did you even try?"
        }
    }
    
    
    @IBAction func Next(sender: AnyObject) {
        let FirstVC = self.storyboard?.instantiateViewControllerWithIdentifier("home") as! ViewController
        self.presentViewController(FirstVC, animated: false, completion: nil)
    }
}