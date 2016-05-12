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
    override func viewDidLoad() {
        super.viewDidLoad()
        ASubject!.text! = subjectTitle
    }
    
    
    @IBOutlet weak var RightorWrong: UILabel!
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var Answer: UILabel!
    
    
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var NextButton: UIButton!
    
    @IBAction func BackButtonAction(sender: AnyObject) {
    }
    
    @IBAction func NextButtonAction(sender: AnyObject) {
    }
    
}
