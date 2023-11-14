//
//  TasksListScreenViewModel.swift
//  Tasks
//
//  Created by Antonio Cypert on 11/13/23.
//

import Foundation
import DittoSwift

class TasksListScreenViewModel: ObservableObject {
    @Published var tasks = [Task]()
    @Published var isPresentingEditScreen: Bool = false
    
    private(set) var taskToEdit: Task? = nil
    
    let ditto: Ditto
    var liveQuery: DittoLiveQuery?
    var subscription: DittoSubscription?
    
    init(ditto: Ditto) {
        self.ditto = ditto
        self.subscription = ditto.store["tasks"].find("!isDeleted").subscribe()
        self.liveQuery = ditto.store["tasks"]
            .find("!isDeleted")
            .observeLocal(eventHandler: { docs, _ in
                self.tasks = docs.map({ Task(document: $0) })
            })
        
        ditto.store["tasks"].find("isDeleted == true").evict()
    }
    
    func toggle(task: Task) {
        self.ditto.store["tasks"].findByID(task._id)
            .update { mutableDoc in
                guard let mutableDoc = mutableDoc else { return }
                
                mutableDoc["isCompleted"].set(!mutableDoc["isCompleted"].boolValue)
            }
    }
    
    func clickedBody(task: Task) {
        taskToEdit = task
        isPresentingEditScreen = true
    }
    
    func clickedPlus() {
        taskToEdit = nil
        isPresentingEditScreen = true
    }
}
