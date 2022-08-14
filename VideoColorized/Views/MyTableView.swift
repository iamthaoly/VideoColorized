//
//  MyTableView.swift
//  VideoColorized
//
//  Created by ly on 14/08/2022.
//

import SwiftUI

struct MyTableRow: Identifiable {
    let id = UUID()
    let cells: [AnyView]
}

struct MyTableView: View {
    let headers: [String]
//    let rows: [MyTableRow] = [MyTableRow(UUID(uuidString: "1"), Text("haha1")), MyTableRow(UUID(uuidString: "2"), Text("haha2"))]
    let rows: [MyTableRow]
    var body: some View {
        HStack {
            ForEach(0..<headers.count) { columnCount in
                if (columnCount != 0) {
                    Spacer()
                }
                VStack {
                    Text(headers[columnCount])
                        .fontWeight(.bold)
                        .padding(.vertical)
                    ForEach(0..<rows.count) { rowCount in
                        rows[rowCount].cells[columnCount]
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MyTableView_Previews: PreviewProvider {
    static var previews: some View {
        MyTableView(headers: [], rows: [])
    }
}
