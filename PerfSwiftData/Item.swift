//
//  Item.swift
//  PerfSwiftData
//
//  Created by Uhl Albert on 8/19/24.
//

import SwiftData
import Foundation

@Model
class Item {
    @Attribute(.unique) var order: Int

    init(order: Int) {
        self.order = order
    }
}
