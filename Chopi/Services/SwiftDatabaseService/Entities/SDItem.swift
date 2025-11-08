//
//  SDItem.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 19/10/25.
//

import Foundation
import SwiftData

@Model
class SDItem {
    @Attribute(.unique) var id: String
    var name: String
    var quantity: Int
    var isPurchased: Bool
    var createdAt: Date
    var list: SDShoppingList?
    
    init(id: String, name: String, quantity: Int, isPurchased: Bool, createdAt: Date, list: SDShoppingList) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.isPurchased = isPurchased
        self.createdAt = createdAt
        self.list = list
    }
}

extension SDItem: ToItemProtocol {
    func toItem() -> Item {
        Item(
            id: id,
            name: name,
            quantity: quantity,
            isPurchased: isPurchased,
            createdAt: createdAt,
            listId: list?.id ?? ""
        )
    }
}
