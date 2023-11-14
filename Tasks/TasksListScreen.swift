//
//  TasksListScreen.swift
//  Tasks
//
//  Created by Antonio Cypert on 11/13/23.
//

import SwiftUI
import DittoSwift

struct TasksListScreen: View {
    let ditto: Ditto
    @ObservedObject var viewModel: TasksListScreenViewModel
    
    init(ditto: Ditto) {
        self.ditto = ditto
        self.viewModel = TasksListScreenViewModel(ditto: ditto)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.tasks) { task in
                    TaskRow(task: task,
                        onToggle: { task in viewModel.toggle(task: task) },
                        onClickBody: { task in viewModel.clickedBody(task: task) }
                    )
                }
            }
            .navigationTitle("Tasks - SwiftUI")
            .navigationBarItems(trailing: Button(action: {
                viewModel.clickedPlus()
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $viewModel.isPresentingEditScreen, content: {
                EditScreen(ditto: ditto, task: viewModel.taskToEdit)
            })
        }
    }
}

struct TasksListScreen_Previews: PreviewProvider {
    static var previews: some View {
        TasksListScreen(ditto: Ditto())
    }
}
