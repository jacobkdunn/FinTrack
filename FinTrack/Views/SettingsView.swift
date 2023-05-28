//
//  SettingsView.swift
//  FinTrack
//
//  Created by Jacob Dunn on 2023-05-25.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) var  categories: FetchedResults<Category>
    
    
    var body: some View {
        NavigationView {
            List(categories) { category in
                NavigationLink{
                    SubcategoryView(category: category)
                } label: { Text(category.name!)
                }
            }
            .navigationTitle("Categories")
            .navigationBarItems(trailing: Button(action: addCategory, label: {
                Image(systemName: "plus")
            }))
        }
        
    }
    func addCategory() {
        presentTextInputAlert(title: "Add Category", message: "Enter Category Name") { text in
            let newCategory = Category(context: viewContext)
            newCategory.name = text
            newCategory.id = UUID()
            try? viewContext.save()
        }
    }
    
}

func presentTextInputAlert(title: String, message: String, completion: @escaping (_ text: String) -> Void) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addTextField()
    let submitAction = UIAlertAction(title: "Save", style: .default) { _ in
        if let text = alert.textFields?.first?.text,
           !text.isEmpty {
            completion(text)
        }
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    alert.addAction(submitAction)
    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
