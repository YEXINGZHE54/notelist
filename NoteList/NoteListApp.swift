//
//  NoteListApp.swift
//  NoteList
//
//  Created by 兆星 李 on 2020/12/26.
//

import SwiftUI

@main
struct NoteListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
