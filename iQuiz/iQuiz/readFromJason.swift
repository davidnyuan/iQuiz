//
//  readFromJason.swift
//  iQuiz
//
//  Created by David Yuan on 5/12/16.
//  Copyright © 2016 David Yuan. All rights reserved.
//

import Foundation



class fromJson {
    
    var targetURL = URLToGo.targetURL
    
    var topicsInQuiz : [Topic] = [Topic]()
    
    var topic : [Topic] = []
    
    var names : [String] = []
    var descrs : [String] = []
    
    // var scienceQs : [Question] = []
    // var mathQs : [Question] = []
    // var marvelQs : [Question] = []
    
    func checkLocalStorage() {
        //Check if json exists
        
        //        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let tempDirURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(NSProcessInfo.processInfo().globallyUniqueString, isDirectory: true)
        let filePath = tempDirURL.URLByAppendingPathComponent("quiz.json").absoluteString
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(filePath) {
            print("FILE AVAILABLE")
        } else {
            print("FILE NOT AVAILABLE")
        }
        
    }
    
    
    func HTTPRequest(completionHandler: () -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: targetURL)!) { (data, response, error) -> Void in
            //          print(self.targetURL)
            let HTTPResponse = response as! NSHTTPURLResponse
            let statusCode = HTTPResponse.statusCode
            
            if (statusCode == 200) {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    
                    // print(json)
                    
                    guard let subject = json as? [[String : AnyObject]] else {return}
                    
                    for s in subject {
                        let name = s["title"] as? String
                        self.names.append(name!)
                        let desc = s["desc"] as? String
                        self.descrs.append(desc!)
                        let questions = s["questions"]

                        var questionObjs : [Question] = []
                        
                        for q in questions as! NSArray {
                            let text = q["text"] as! String
                            let correctAnswerInt = q["answer"] as! String
                            let answerList = q["answers"] as! [String]
                            let correctAnswer = answerList[(Int(correctAnswerInt)! - 1)]
                            let inputquestion : Question = Question(text: text, answer: correctAnswer, choices: answerList)
                            questionObjs.append(inputquestion)
                        }
                        let inputtopic: Topic = Topic(subject: String(name), desc: String(desc), questions: questionObjs)
                        self.topic.append(inputtopic)
                    }
                    
                    completionHandler()
                    
                } catch {
                    print("Error Response! \n\(error)")
                }
            }
        }
        task.resume()
    }
}
