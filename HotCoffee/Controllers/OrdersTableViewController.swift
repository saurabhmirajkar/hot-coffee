//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Saurabh Mirajkar on 17/01/24.
//

import Foundation
import UIKit


class OrdersTableViewController: UITableViewController {
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    func populateOrders() {
        guard let coffeeOrderUrl = URL(string: "https://warp-wiry-rugby.glitch.me/orders") else {
            fatalError("URL was incorrect")
        }
        
        let resource = Resource<[Order]>(url: coffeeOrderUrl)
        
        Webservices().load(resource: resource) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        let vm = orderListViewModel.orderViewModel(at: indexPath.row)
     
        var content = cell.defaultContentConfiguration()
        content.text = vm.type
        content.secondaryText = vm.size
        cell.contentConfiguration = content
        
        return cell
    }
}
