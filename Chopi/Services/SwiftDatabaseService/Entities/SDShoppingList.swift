//
//  SDShoppingList.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 19/10/25.
//

import Foundation
import SwiftData

@Model
class SDShoppingList {
    @Attribute(.unique) var id: String
    var name: String
    var createdAt: Date
    @Relationship(deleteRule: .cascade) var items: [SDItem] = []
    
    init(id: String, name: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
}

extension SDShoppingList: ToShoppingListProtocol {
    func toShoppingList() -> ShoppingList {
        ShoppingList(
            id: id,
            name: name,
            createdAt: createdAt,
            itemCount: items.count
        )
    }
}
