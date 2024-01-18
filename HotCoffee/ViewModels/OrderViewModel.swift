//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by Saurabh Mirajkar on 18/01/24.
//

import Foundation

class OrderListViewModel {
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = [OrderViewModel]()
    }
    
    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}

struct OrderViewModel {
    let order: Order
    
    var name : String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }
    
    var size: String {
        return self.order.size.rawValue.capitalized
    }
    
}
