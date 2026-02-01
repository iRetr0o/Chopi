//
//  Item.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 11/10/25.
//

import Foundation

struct Item: Identifiable, Hashable {
    let id: String
    let name: String
    let quantity: Int
    let isPurchased: Bool
    let createdAt: Date
    let listId: String
}
