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
    
    @FetchRequest(sortDescriptors: []) var  categories: FetchedResults<Category>
    @FetchRequest(sortDescriptors: []) var subcategories: FetchedResults<Subcategory>

    
    @State var vendor: String = ""
    @State var description: String = ""
    @State var amount: String = ""
 
    @State var chosenCategory: String = ""
    @State var chosenSubcategory: String = ""

    var body: some View {
        
        NavigationView {
            VStack {
                Text("Add an Expense")
                Form {
                    TextField("Vendor", text: $vendor)
                    
                    TextField("Description", text: $description, axis: .vertical)
                    
                    TextField("Amount ($)", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker(selection: $chosenCategory, label: Text("Category")) {
                        
                        Text("").tag("")
                        
                        ForEach(categories, id: \.self) { (category: Category) in
                            Text(category.name!).tag(category.name!)
                           }
                        
                    }
                    .onChange(of: chosenCategory) { newValue in
                        // Runs whenever chosen category changes
                        subcategories.nsPredicate = NSPredicate(format: "parentCategory.name == %@", newValue)
                       
                        
                    }
                    
                    if subcategories.count > 0 {
                        
                        Picker(selection: $chosenSubcategory, label: Text("Subcategory")) {
                            
                            Text("").tag("")
                            
                            ForEach(subcategories, id: \.self) { (subcategory: Subcategory) in
                                Text(subcategory.name!).tag(subcategory.name!)
                            }
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
            let newItem = TrackerListEntry(context: viewContext)
            newItem.itemTitle = vendor
            newItem.itemDescription = description
            newItem.itemAmount = Double(amount) ?? 0.00
//            newItem.itemCategory = category
//            newItem.itemSubcategory = subcategory
            newItem.itemTimeStamp = Date()
            newItem.itemTransactionTime = Date()
            print($chosenCategory)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
//            func getCoreDataDBPath()
            
//            getCoreDataDBPath()
        }
    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExpenseEntryView()
//    }
//}
