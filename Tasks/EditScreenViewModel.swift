//
//  EditScreenViewModel.swift
//  Tasks
//
//  Created by Antonio Cypert on 11/13/23.
//

import Foundation
import SwiftUI
import DittoSwift

class EditScreenViewModel: ObservableObject {
    @Published var canDelete: Bool = false
    @Published var body: String = ""
    @Published var isCompleted: Bool = false
    
    private let _id: String?
    private let ditto: Ditto
    
    init(ditto: Ditto, task: Task?) {
        self._id = task?._id
        self.ditto = ditto
        
        canDelete = task != nil
        body = task?.body ?? ""
        isCompleted = task?.isCompleted ?? false
    }
    
    func save() {
        if let _id = _id {
            // the user is attempting to update an existing task
            ditto.store["tasks"].findByID(_id).update({ mutableDoc in
                mutableDoc?["isCompleted"].set(self.isCompleted)
                mutableDoc?["body"].set(self.body)
            })
        } else {
            try! ditto.store["tasks"].upsert([
                "body": body,
                "isCompleted": isCompleted,
                "isDeleted": false
            ])
        }
    }
    
    func delete() {
        guard let _id = _id else { return }
        ditto.store["tasks"].findByID(_id).update { doc in
            doc?["isDeleted"].set(true)
        }
    }
}
