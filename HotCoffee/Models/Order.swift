//
//  Order.swift
//  HotCoffee
//
//  Created by Saurabh Mirajkar on 18/01/24.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino, latte, espresso, cortodo
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small, medium, large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
    
    init?(_ vm: AddCoffeeOrderViewModel) {
        
        guard let name = vm.name,
              let email = vm.email,
              let type = CoffeeType(rawValue: vm.selectedType!.lowercased()),
              let size = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) 
        else {
            return nil
        }
        
        self.name = name
        self.email = email
        self.type = type
        self.size = size
    }
    
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        return Resource<[Order]>(url: url)
    }()
    
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        let order = Order(vm)
        
        guard let url = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL is incorrect!")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Error encoding order!")
        }
        
        var resource = Resource<Order?>(url: url)
        
        resource.httpMethod = .post
        resource.body = data
        
        return resource
    }
    
}
