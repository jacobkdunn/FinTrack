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
        sortDescriptors: [NSSortDescriptor(keyPath: \Type.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Type>
    
    
    
    @State var vendor: String = ""
    @State var description: String = ""
    @State var amount: String = ""
 
    @State var category = ""
    @State var currentCategoryIndex = 0 {
        didSet {
            category = categories[currentCategoryIndex]
        }
    }
    let categories: [String] = [
        "Groceries",
        "Housing",
        "Take out/Order in",
        "Transportation",
        "Savings",
        "School",
        "Travel",
        "Miscellaneous",
        "Not Applicable"
    ]
    
    @State var subcategory = ""
    @State var currentSubcategoryIndex = 0 {
        didSet {
            subcategory = subcategories[currentSubcategoryIndex]
        }
    }
    let subcategories: [String] = [
        "Subcategory 1",
        "Subcategory 2"
    ]

    var body: some View {
        
        NavigationView {
            VStack {
                Text("Add an Expense")
                Form {
                    TextField("Vendor", text: $vendor)
                    
                    TextField("Description", text: $description, axis: .vertical)
                    
                    TextField("Amount ($)", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker(selection: $category, label: Text("Category")) {
                        ForEach(categories, id: \.self) { index in
                               Text(index)
                           }
                        }

                    Picker(selection: $subcategory, label: Text("Subcategory")) {
                        ForEach(subcategories, id: \.self) { index in
                               Text(index)
                           }
                        }
                }
                Button("Add") {
                    addItem()
                }
                .buttonStyle(.bordered)
                
                
                
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.itemTitle = vendor
            newItem.itemDescription = description
            newItem.itemAmount = Double(amount)!
            newItem.itemCategory = category
            newItem.itemSubcategory = subcategory
            newItem.itemTimeStamp = Date()
            newItem.itemTransactionTime = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            func getCoreDataDBPath() {
                    let path = FileManager
                        .default
                        .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                        .last?
                        .absoluteString
                        .replacingOccurrences(of: "file://", with: "")
                        .removingPercentEncoding

                    print("Core Data DB Path :: \(path ?? "Not found")")
                }
            
            getCoreDataDBPath()
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
