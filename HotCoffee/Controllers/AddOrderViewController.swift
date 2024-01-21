//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by Saurabh Mirajkar on 17/01/24.
//

import Foundation
import UIKit

protocol AddOrderDelegate {
    func orderDidSave(order: Order, controller: UIViewController)
    func orderDidClose(controller: UIViewController)
}

class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var vm = AddCoffeeOrderViewModel()
    
    var delegate: AddOrderDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.segmentControl = UISegmentedControl(items: self.vm.sizes)
        self.segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.segmentControl)
        
        
        self.segmentControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        
        self.segmentControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = vm.types[indexPath.row]
        
        cell.contentConfiguration = content
        
        return cell
        
    }
    
    @IBAction func save() {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.segmentControl.titleForSegment(at: self.segmentControl.selectedSegmentIndex)
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {fatalError("Error in selecting coffee")}
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedSize = selectedSize
        self.vm.selectedType = self.vm.types[indexPath.row]
        
        Webservices().load(resource: Order.create(vm: self.vm)) { result in
            switch result {
            case .success(let order):
                
                if let order = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        delegate.orderDidSave(order: order, controller: self)
                    }
                }
                
            case .failure(let error): print(error)
            }
        }
        
    }
    
    @IBAction func close() {
        if let delegate = self.delegate {
            delegate.orderDidClose(controller: self)
        }
    }
    
}
