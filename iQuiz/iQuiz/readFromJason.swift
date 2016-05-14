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
                        let name = s["title"] as? NSString
                        self.names.append(String(name))
                        let desc = s["desc"] as? NSString
                        self.descrs.append(String(desc))
                        let questions = s["questions"] as! NSArray

                        var questionObjs = [Question]()
                        for q in questions {
                            let qtext = q["text"] as? NSString
                            let qanswer = q["answer"] as? NSString
                            let qanswers = q["answers"] as! NSArray
                            var answerstringarray = [String]()
                            for individual in qanswers {
                                answerstringarray.append(String(individual))
                            }
                            let inputquestion : Question = Question(text: String(qtext), answer: String(qanswer!), choices: answerstringarray)
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
