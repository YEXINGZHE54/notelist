//
//  NoteListModel.swift
//  NoteList
//
//  Created by 兆星 李 on 2020/12/26.
//

import SwiftUI
import CoreData

class NoteListModel: ObservableObject {
    let viewContext = PersistenceController.shared.container.viewContext
    private var clipboard: Clipboard
    private var lastCopied: String = ""
    
    init() {
        clipboard = Clipboard()
        clipboard.startListening()
        clipboard.onNewCopy { (content) in
            self.addItem(content: content)
        }
    }
    
    private func addItem(content: String) {
        if lastCopied == content {
            lastCopied = ""
            return
        }
        let newItem = Item(context: viewContext)
        newItem.timestamp = Date()
        newItem.text = content
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func copy(_ content: String) {
        lastCopied = content
        clipboard.copy(content)
    }
}
