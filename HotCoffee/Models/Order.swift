//
//  Order.swift
//  HotCoffee
//
//  Created by Saurabh Mirajkar on 18/01/24.
//

import Foundation

enum CoffeeType: String, Codable {
    case cappuccino, latte, espresso, cortodo
}

enum CoffeeSize: String, Codable {
    case small, medium, large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}