//
//  QuestionController.swift
//  iQuiz
//
//  Created by David Yuan on 5/10/16.
//  Copyright © 2016 David Yuan. All rights reserved.
//

import Foundation
import UIKit

class QuestionController: UIViewController {
    
    @IBOutlet weak var Qsubject: UILabel!
    var subjectTitle = ""
    
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var ButtonAnswer: UIButton!
    
    var b1 = false
    var b2 = false
    var b3 = false
    var b4 = false
    var topicnumber: Int!
    var right = 0
    var total = 0
    var topic : Topic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Qsubject!.text! = subjectTitle
        QuestionLabel.text = topic?.questions[total].text
    }
    
    func buttonClicked() {
        b1 = false
        b2 = false
        b3 = false
        b4 = false
        Button1.backgroundColor = UIColor.blueColor()
        Button2.backgroundColor = UIColor.blueColor()
        Button3.backgroundColor = UIColor.blueColor()
        Button4.backgroundColor = UIColor.blueColor()
    }
    
    @IBAction func Button1Action(sender: AnyObject) {
        buttonClicked()
        b1 = true
        Button1.backgroundColor = UIColor.redColor()
    }
    
    @IBAction func Button2Action(sender: AnyObject) {
        buttonClicked()
        b2 = true
        Button2.backgroundColor = UIColor.redColor()
    }
    
    @IBAction func Button3Action(sender: AnyObject) {
        buttonClicked()
        b3 = true
        Button3.backgroundColor = UIColor.redColor()
    }
    
    @IBAction func Button4Action(sender: AnyObject) {
        buttonClicked()
        b4 = true
        Button4.backgroundColor = UIColor.redColor()
    }
    
    @IBAction func ButtonAnswerAction(sender: AnyObject) {
        if(b1 || b2 || b3 || b4) {
            total += 1
            let ThirdVC = self.storyboard?.instantiateViewControllerWithIdentifier("AnswerC") as! AnswerController
            ThirdVC.subjectTitle = subjectTitle
            self.presentViewController(ThirdVC, animated: false, completion: nil)
        }
    }
}