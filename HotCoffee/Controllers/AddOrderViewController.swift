//
//  AddOrderViewController.swift
//  HotCoffee
//
//  Created by Saurabh Mirajkar on 17/01/24.
//

import Foundation
import UIKit

class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var vm = AddCoffeeOrderViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
}
