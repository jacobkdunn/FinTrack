//
//  SubcategoryView.swift
//  FinTrack
//
//  Created by Jacob Dunn on 2023-05-26.
//

import SwiftUI

private var category: Category?

struct SubcategoryView: View {
    
    var category: Category

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "parentCategory.name != %@", "")) var  subcategories: FetchedResults<Subcategory>

    
    var body: some View {
        List(subcategories) { subcategory in
           Text(subcategory.name!)
        }
        .navigationTitle(category.name ?? "ERROR NO NAME")
        .navigationBarItems(trailing: Button(action: addCategory, label: {
            Image(systemName: "plus")
        }))
        .onAppear {
            subcategories.nsPredicate = NSPredicate(format: "parentCategory.name == %@", category.name!)
        }
            
    }
    
    func addCategory() {
        presentTextInputAlert(title: "Add Subcategory", message: "Enter Subcategory Name") { text in
            let newSubcategory = Subcategory(context: viewContext)
            newSubcategory.name = text
            newSubcategory.id = UUID()
            category.addToSubcategories(newSubcategory)
            try? viewContext.save()
        }
    }

}

//struct SubcategoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        SubcategoryView(category: "Test")
//    }
//}
