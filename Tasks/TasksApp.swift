//
//  TasksApp.swift
//  Tasks
//
//  Created by Antonio Cypert on 11/13/23.
//

import SwiftUI
import DittoSwift

@main
struct TasksApp: App {
    var ditto = Ditto(identity: .onlinePlayground(appID: "94dd2237-f5fe-4074-981c-05adb9e3bd9f", token: "1288ebe8-8217-4b72-aca4-48d5b6635632"))
    
    @State var isPresentingAlert = false
    @State var errorMessage = ""

    var body: some Scene {
        WindowGroup {
            TasksListScreen(ditto: ditto)
                .onAppear(perform: {
                    do {
                        try ditto.startSync()
                    } catch (let err) {
                        isPresentingAlert = true
                        errorMessage = err.localizedDescription
                    }
                })
                .alert(isPresented: $isPresentingAlert) {
                    Alert(title: Text("Uh oh"), message: Text("There was an error trying to start the sync. Here's the error \(errorMessage) Ditto will continue working as a local database."), dismissButton: .default(Text("Got it!")))
                }
        }
    }
}
