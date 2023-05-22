//
//  ContentView.swift
//  FinTrack
//
//  Created by Jacob Dunn on 2023-05-20.
//

import SwiftUI
import CoreData



struct ExpenseEntryView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State var vendor: String = ""
    @State var description: String = ""
    @State var amount: String = ""

    var body: some View {
        
        NavigationView {
            VStack {
                Text("Add an Expense")
                Form {
                    TextField("Vendor", text: $vendor)
                    TextField("Description", text: $description, axis: .vertical)
                    TextField("Amount ($)", text: $amount)
                        .keyboardType(.decimalPad)
                    Picker(selection: .constant(0), label: Text("Category")) {
                        Text("Groceries").tag(0)
                        Text("Housing").tag(1)
                        Text("Take out/Order in").tag(2)
                        Text("Transportation").tag(3)
                        Text("Savings").tag(4)
                        Text("School").tag(5)
                        Text("Travel").tag(6)
                        Text("Miscellaneous").tag(7)
                        Text("Not Applicable").tag(8)
                    }
                    Picker("Subcategory", selection: .constant(1)) {
                        Text("Text").tag(1)
                    }
                }
                Button("Add") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                .buttonStyle(.bordered)
                
                
                
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

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

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseEntryView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
