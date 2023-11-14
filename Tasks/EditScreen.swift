//
//  EditScreen.swift
//  Tasks
//
//  Created by Antonio Cypert on 11/13/23.
//

import Foundation
import SwiftUI
import DittoSwift

struct EditScreen: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel: EditScreenViewModel
    
    init(ditto: Ditto, task: Task?) {
        viewModel = EditScreenViewModel(ditto: ditto, task: task)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Body", text: $viewModel.body)
                    Toggle("Is Completed", isOn: $viewModel.isCompleted)
                }
                Section {
                    Button(action: {
                        viewModel.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text(viewModel.canDelete ? "Save" : "Create")
                    })
                }
                
                if viewModel.canDelete {
                    Section {
                        Button(action: {
                            viewModel.delete()
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Delete").foregroundColor(.red)
                        })
                    }
                }
            }
            .navigationTitle(viewModel.canDelete ? "Edit Task": "Create Task")
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }))
        }
    }
}

struct EditScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditScreen(ditto: Ditto(), task: Task(body: "Get Milk", isCompleted: true))
    }
}
