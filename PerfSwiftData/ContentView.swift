//
//  ContentView.swift
//  PerfSwiftData
//
//  Created by Uhl Albert on 8/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.order, order: .forward) private var items: [Item]

    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    List {
                        ForEach(items) { item in
                            Text("Item \(item.order)")
                                .id(item.order)
                        }
                    }
                    .onChange(of: items.count) {
                        scrollToBottom(proxy: proxy)
                    }
                }
                HStack {
                    Button(action: addItems) {
                        Text("Add 100 Items")
                    }
                    .buttonStyle(.borderedProminent)                     .buttonBorderShape(.roundedRectangle)

                    Button(role: .destructive, action: deleteAllItems) {
                        Text("Delete All")
                    }
                    .buttonStyle(.bordered)                     .buttonBorderShape(.roundedRectangle)
                }
            }
            .navigationTitle("SwiftData")
        }
    }

    private func addItems() {
        withAnimation {
            let maxOrder = items.last?.order ?? 0

            for i in 1...100 {
                let newItem = Item(order: maxOrder + i)
                modelContext.insert(newItem)
            }
            do {
                try modelContext.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    private func deleteAllItems() {
        for item in items {
            modelContext.delete(item)
        }
        do {
            try modelContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        if let lastItem = items.last {
            withAnimation {
                proxy.scrollTo(lastItem.order, anchor: .bottom)
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
