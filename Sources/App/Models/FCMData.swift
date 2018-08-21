//
//  FCMData.swift
//  App
//
//  Created by Girish Bodhe on 16/08/18.
//

import FluentSQLite
import Vapor

/// A single entry of a FCMData list.
final class FCMData: SQLiteModel {
    
    var id: Int?
 
    var topic: String
    
    var title: String
    
    var body : String
    
    var userID: User.ID
    
    /// Creates a new `FCMData`.
    init(id: Int? = nil, topic: String,title: String, body: String, userID: User.ID) {
        self.id = id
        self.title = title
        self.userID = userID
        self.body = body
        self.topic = topic
    }
}

extension FCMData {
    /// Fluent relation to user that owns this todo.
    var user: Parent<FCMData, User> {
        return parent(\.userID)
    }
}

/// Allows `FCMData` to be used as a Fluent migration.
extension FCMData: Migration {
    static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return SQLiteDatabase.create(FCMData.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.title)
            builder.field(for: \.body)
            builder.field(for: \.userID)
            builder.reference(from: \.userID, to: \User.id)
        }
    }
}

/// Allows `FCMData` to be encoded to and decoded from HTTP messages.
extension FCMData: Content { }

/// Allows `FCMData` to be used as a dynamic parameter in route definitions.
extension FCMData: Parameter { }
