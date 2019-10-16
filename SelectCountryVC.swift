//
//  SelectCountryVC.swift
//  SelectCountry
//
//  Created by Bloveocean on 2019/10/16.
//  Copyright © 2019 Auth. All rights reserved.
//

import UIKit

class SelectCountryVC: UIViewController {

    var searchController: UISearchController!
    var tableView: UITableView!
    
    var dataSource: [Int] = []
    var filted: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for idx in 0 ..< 10 {
            dataSource.append(idx)
        }

        // Do any additional setup after loading the view.
        
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
    }

}

extension SelectCountryVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let txt = searchController.searchBar.text else {return}
        if let num = Int(txt) {
            filted = [num]
        }
        
        self.tableView.reloadData()
    }
    
    
}

extension SelectCountryVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchController.isActive {
            return self.filted.count
        }
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var num = 0;
        if self.searchController.isActive {
           num = self.filted[indexPath.row]
        } else {
            num = self.dataSource[indexPath.row]
        }
        
        cell.textLabel?.text = "\(num)"
        
        return cell
    }
    
}
