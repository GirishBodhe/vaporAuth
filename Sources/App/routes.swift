import Crypto
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // public routes
    
    
    let userController = UserController()
    let todoController = TodoController()
    let fcmController = FCMController()
    router.post("users", use: userController.create)
   
    // basic / password auth protected routes
    let basic = router.grouped(User.basicAuthMiddleware(using: BCryptDigest()))
    basic.post("/postNotification", use: fcmController.send)
    basic.post("login", use: userController.login)
    basic.get("todos", use: todoController.index)
    basic.post("todos", use: todoController.create)
    basic.delete("todos", Todo.parameter, use: todoController.delete)
    
    
//    router.post("/postNotification") { req -> Future<HTTPStatus> in
//        return try req.content.decode(MessageRequest.self).map(to: HTTPStatus.self) { messageRequest in
//            
//            let fcm = try req.make(FCM.self)
//            //        let token = "token"
//            let topic = messageRequest.topic
//            let notification = FCMNotification(title: messageRequest.title, body: "\(messageRequest.body) ❤️")
//            let message = FCMMessage(topic: topic, notification: notification)
//            //        let message = FCMMessage(token: token, notification: notification)
//            try fcm.sendMessage(req.client(), message: message)
//            
//            return .ok
//        }
//    }
//    // bearer / token auth protected routes
//    let bearer = router.grouped(User.tokenAuthMiddleware())
//    
//    bearer.get("todos", use: todoController.index)
//    bearer.post("todos", use: todoController.create)
//    bearer.delete("todos", Todo.parameter, use: todoController.delete)
//    
}
