//
//  ContentView.swift
//  NoteList
//
//  Created by 兆星 李 on 2020/12/26.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let noteListModel = NoteListModel()
    
    var body: some View {
        List {
            ForEach(items) { item in
                Text(item.text!)
                    .frame(height: 25, alignment: .leading)
                    .padding(10)
                    //给view添加边框与圆角
                    .overlay(
                         RoundedRectangle(cornerRadius: 8, style: .continuous)
                             .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(10)
                    .onTapGesture{
                        noteListModel.copy(item.text!)
                    }

            }
            .onDelete(perform: deleteItems)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
