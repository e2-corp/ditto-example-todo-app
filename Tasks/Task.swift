//
//  Task.swift
//  Tasks
//
//  Created by Antonio Cypert on 11/13/23.
//

import DittoSwift

struct Task {
    let _id: String
    let body: String
    let isCompleted: Bool
    
    init(document: DittoDocument) {
        _id = document["_id"].stringValue
        body = document["body"].stringValue
        isCompleted = document["isCompleted"].boolValue
    }
    
    init(body: String, isCompleted: Bool) {
        self._id = UUID().uuidString
        self.body = body
        self.isCompleted = isCompleted
    }
}

extension Task: Identifiable {
    var id: String {
        return _id
    }
}
