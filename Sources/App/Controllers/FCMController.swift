//
//  FCMController.swift
//  App
//
//  Created by Girish Bodhe on 16/08/18.
//

import Foundation
import Vapor
import FluentSQLite


/// Simple todo-list controller.
final class FCMController {
    
    /// Returns a list of all todos for the auth'd user.
    func send(_ req: Request) throws -> String {
        
        
        _ = try req.requireAuthenticated(User.self)
        
        
        // decode request content
//        return try req.content.decode(MessageRequest.self).flatMap { fmassage in
            // save new todo

            
            
            
            let headers = [
                "Content-Type": "application/json",
                "Cache-Control": "no-cache",
                "Authorization":"key=AAAAo-zXUOA:APA91bEenzz4-O5Q8FBdkd0EcUBrxX10In-U7EPEYFWzO3fsixq8ye08Ynw7P6eVY3yXjb3L_QJCx99otdkENA82OmyBlC_Xku9JbvpJBUwdlwdI6qHw9S7TiWGeMEOJjYalE-uYnKwC2NoKaMkLaUBqk-jHKaY2ag",
                "Postman-Token": "5e7722de-0bbb-4aac-922b-8436879a5067"
            ]
//
//            {
//                "to": "/topics/newHotel",
//                "notification" : {
//                    "body" : "great match!",
//                    "content_available" : true,
//                    "priority" : "high",
//                    "title" : "Portugal vs. Denmark"
//                },
//                "data" : {
//                    "body" : "great match!",
//                    "content_available" : true,
//                    "priority" : "high",
//                    "title" : "Portugal vs. Denmark"
//                }
//            }
            
            let notification = [
                
                "body" : "great match!",
                "content_available" : true,
                "priority" : "high",
                "title" : "Portugal vs. Denmark"
                
                ]as [String : Any]
            
            let data = [
                "body" : "great match!",
                "content_available" : true,
                "priority" : "high",
                "title" : "Portugal vs. Denmark"

                ] as [String : Any]
            
            let parameters = [
                "to": "/topics/newHotel",
                "notification": notification,
                "data": data
                ] as [String : Any]
            
            
            let postData = try JSONSerialization.data(withJSONObject: parameters, options:.prettyPrinted)
        
        
        let url = URL(string: "https://fcm.googleapis.com/fcm/send")
        let request = NSMutableURLRequest(url: url!,
                                              cachePolicy: .useProtocolCachePolicy,
                                              timeoutInterval: 10.0)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error as Any)
                    
                    
                    
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse as Any)
//                    return try "Girish"
                }
            })
        
        
            dataTask.resume()
        
//            //
////            try FCMData(topic:fmassage.topic, title: fmassage.title, body: fmassage.body, userID: user.requireID()).save(on: req)
//
//        let fcm = try req.make(FCM.self)
//        //        let token = "token"
//        let topic = fmassage.topic
//        let notification = FCMNotification(title: fmassage.title, body: "\(fmassage.body) ❤️")
//        let message = FCMMessage(topic: topic, notification: notification)
//        //        let message = FCMMessage(token: token, notification: notification)
//            return try fcm.sendMessage(req.client(), message: message)
//
//        }
   
        
        
   return "Girish"
    }
    
}

// MARK: Content

struct MessageRequest: Content {
    var topic: String
    var title: String
    var body: String
}
