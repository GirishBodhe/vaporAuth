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
    
    // bearer / token auth protected routes
//    let bearer = router.grouped(User.tokenAuthMiddleware())
//    
//    bearer.get("todos", use: todoController.index)
//    bearer.post("todos", use: todoController.create)
//    bearer.delete("todos", Todo.parameter, use: todoController.delete)
//    
}
