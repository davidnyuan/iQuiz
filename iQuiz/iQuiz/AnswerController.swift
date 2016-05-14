//
//  AnswerController.swift
//  iQuiz
//
//  Created by David Yuan on 5/11/16.
//  Copyright © 2016 David Yuan. All rights reserved.
//

import Foundation
import UIKit

class AnswerController: UIViewController {
    
    @IBOutlet weak var ASubject: UILabel!
    var subjectTitle = ""
    
    @IBOutlet weak var RightorWrong: UILabel!
    var RoW = ""
    @IBOutlet weak var Question: UILabel!
    var Q = ""
    @IBOutlet weak var Answer: UILabel!
    var A = ""
    
    var Guessed = ""
    
    var right = 0
    var totalGuessed = 0
    var totalQuestions = 0
    var topic : Topic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ASubject!.text! = subjectTitle
        Question!.text! = Q
        Answer!.text! = "The correct answer is \(A)"
        if(Guessed == A) {
            RoW = "You are correct!"
        } else {
            RoW = "You are Incorrect: You guessed \(Guessed)"
        }
        RightorWrong!.text! = RoW
    }
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    
    @IBAction func BackButtonAction(sender: AnyObject) {
        let FirstVC = self.storyboard?.instantiateViewControllerWithIdentifier("home") as! ViewController
        self.presentViewController(FirstVC, animated: false, completion: nil)
    }
    
    @IBAction func NextButtonAction(sender: AnyObject) {
        if(totalGuessed < totalQuestions) {
            let SecondVC = self.storyboard?.instantiateViewControllerWithIdentifier("QuestionC") as! QuestionController
            SecondVC.totalGuessed = self.totalGuessed
            SecondVC.totalQuestions = topic!.questions.count
            SecondVC.topic = self.topic
            SecondVC.subjectTitle = self.subjectTitle
            SecondVC.right = self.right
            self.presentViewController(SecondVC, animated: false, completion: nil)
        } else {
            NSLog("bump")
        }
    }
    
}
