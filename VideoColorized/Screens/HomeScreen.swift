//
//  HomeScreen.swift
//  VideoColorized
//
//  Created by ly on 11/08/2022.
//

import SwiftUI


struct HomeScreen: View {
    var body: some View {
        ContentView()
            .frame(minWidth: 500, minHeight: 600)
//        MyTableView(headers: [])
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
//        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
//        HomeScreen().environment(\.managedObjectContext, viewContext)
        HomeScreen()
    }
}
