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
    func send(_ req: Request) throws -> Future<String> {
        
        
        _ = try req.requireAuthenticated(User.self)
        
        
        // decode request content
//        return try req.content.decode(MessageRequest.self).flatMap { fmassage in
            // save new todo
        

        return try req.content.decode(MessageRequest.self).map(to: String.self) { messageRequest -> String in
            let headers = [
                "Content-Type": "application/json",
                "Cache-Control": "no-cache",
                "Authorization":"key=AAAAo-zXUOA:APA91bEenzz4-O5Q8FBdkd0EcUBrxX10In-U7EPEYFWzO3fsixq8ye08Ynw7P6eVY3yXjb3L_QJCx99otdkENA82OmyBlC_Xku9JbvpJBUwdlwdI6qHw9S7TiWGeMEOJjYalE-uYnKwC2NoKaMkLaUBqk-jHKaY2ag",
                "Postman-Token": "5e7722de-0bbb-4aac-922b-8436879a5067"
            ]
            let notification = [
                "body" : messageRequest.body,
                "content_available" : true,
                "priority" : "high",
                "title" : messageRequest.title
                ]as [String : Any]
            let data = [
                "body" : messageRequest.body,
                "content_available" : true,
                "priority" : "high",
                "title" : messageRequest.title
                ] as [String : Any]
            let parameters = [
                "to": messageRequest.topic,
                "notification": notification,
                "data": data
                ] as [String : Any]
            let postData = try JSONSerialization.data(withJSONObject: parameters, options:.prettyPrinted)
            let targetURL = URL(string: "https://fcm.googleapis.com/fcm/send")
            var request = URLRequest(url: targetURL!)
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
                    
                }
            })
            dataTask.resume()
            throw Abort(.created, reason: "Notification..")
        }
    }
}

// MARK: Content

struct MessageRequest: Content {
    var topic: String
    var title: String
    var body: String
}
