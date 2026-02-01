//
//  ShoppingList.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import Foundation

struct ShoppingList: Identifiable, Hashable {
    let id: String
    let name: String
    let createdAt: Date
    let itemCount: Int
}
