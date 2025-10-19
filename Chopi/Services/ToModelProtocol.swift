//
//  ToShoppingListProtocol.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import Foundation

protocol ToModelProtocol {
    func toShoppingList() -> ShoppingList
    func toItem() -> Item
}
