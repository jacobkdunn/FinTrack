//
//  ListView.swift
//  FinTrack
//
//  Created by Jacob Dunn on 2023-05-25.
//

import SwiftUI
import CoreData

let testData: [String: String] = ["First": "1", "Second":"2"]



//MARK: - List View Row

struct ListViewRow: View {
    
    var body: some View {
        Text(testData["First"]!)
    }
}

struct ListViewRow_Previews: PreviewProvider {
    
    static var previews: some View {
        ListViewRow()
    }
}

//MARK: - List View

struct ListView: View {
    
    
    
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.itemTitle, ascending: true)],
//        animation: .default)
    
    @FetchRequest(sortDescriptors: []) var TrackerListEntries: FetchedResults<TrackerListEntry>
    
    
    var body: some View {
        List {
            ForEach(TrackerListEntries) { item in
//                HStack {
//                    Text(item.itemTitle!)
//                    Spacer()
//                    Image(systemName: "carrot")
//                }
                Label(item.itemTitle!, systemImage: "carrot")

            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


