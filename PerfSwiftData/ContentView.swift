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
                    ScrollView {
                        LazyVStack {
                            ForEach(items) { item in
                                Text("Item \(item.order)")
                                    .id(item.order)
                            }
                        }
                    }
                    .onChange(of: items.count) {
                        scrollToBottom(proxy: proxy)
                    }
                }
                Button(action: addItems) {
                    Text("Add 50 Items")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("SwiftData")
        }
    }

    private func addItems() {
        withAnimation {
            let maxOrder = items.last?.order ?? 0

            for i in 1...50 {
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
