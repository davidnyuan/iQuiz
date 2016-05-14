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
    var right = 0
    var total = 0
    var topic : Topic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Qsubject!.text! = subjectTitle
        QuestionLabel.text = topic!.questions[total].text
        Button1.setTitle(topic!.questions[total].choices[0], forState: UIControlState.Normal)
        Button2.setTitle(topic!.questions[total].choices[1], forState: UIControlState.Normal)
        Button3.setTitle(topic!.questions[total].choices[2], forState: UIControlState.Normal)
        Button4.setTitle(topic!.questions[total].choices[3], forState: UIControlState.Normal)
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
            let ThirdVC = self.storyboard?.instantiateViewControllerWithIdentifier("AnswerC") as! AnswerController
            ThirdVC.subjectTitle = subjectTitle
            ThirdVC.Q = topic!.questions[total].text
            ThirdVC.A = topic!.questions[total].answer
            if(b1) {
                ThirdVC.Guessed = topic!.questions[total].choices[0]
                if(topic!.questions[total].choices[0] == topic!.questions[total].answer) {
                    right += 1
                }
            } else if(b2) {
                ThirdVC.Guessed = topic!.questions[total].choices[1]
                if(topic!.questions[total].choices[1] == topic!.questions[total].answer) {
                    right += 1
                }
            } else if(b3) {
                ThirdVC.Guessed = topic!.questions[total].choices[2]
                if(topic!.questions[total].choices[2] == topic!.questions[total].answer) {
                    right += 1
                }
            } else {
                ThirdVC.Guessed = topic!.questions[total].choices[3]
                if(topic!.questions[total].choices[3] == topic!.questions[total].answer) {
                    right += 1
                }
            }
            
            total += 1
            self.presentViewController(ThirdVC, animated: false, completion: nil)
        }
    }
}