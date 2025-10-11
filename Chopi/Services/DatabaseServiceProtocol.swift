//
//  DatabaseServiceProtocol.swift
//  Chopi
//
//  Created by Oscar Gutierrez on 28/09/25.
//

import Foundation

protocol DatabaseServiceProtocol {
    func fetchLists() async -> [ShoppingList]
    func saveList(_ list: ShoppingList) async -> Bool
    func updateList(_ list: ShoppingList) async -> Bool
    func deleteList(_ list: ShoppingList) async -> Bool
}
