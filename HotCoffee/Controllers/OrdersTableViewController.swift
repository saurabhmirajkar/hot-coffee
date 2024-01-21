//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Saurabh Mirajkar on 17/01/24.
//

import Foundation
import UIKit


class OrdersTableViewController: UITableViewController, AddOrderDelegate {
    
    
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    func populateOrders() {
       Webservices().load(resource: Order.all) { [weak self] result in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let orderVC = navC.viewControllers.first as? AddOrderViewController else {
            fatalError("Error performing order")
        }
        
        orderVC.delegate = self
    }
    
    func orderDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true)
        let orderVM = OrderViewModel(order: order)
        
        self.orderListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    
    func orderDidClose(controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}
