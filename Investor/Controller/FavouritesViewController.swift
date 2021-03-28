//
//  FavouritesViewController.swift
//  Investor
//
//  Created by Alla Kim on 28.03.2021.
//

import UIKit

class FavouritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tempArray = ["iPhone", "Macbook", "Ipad", "iMac", "AirPods", "Apple Watch", "iPhone", "Macbook", "iPad", "iMac", "AirPods", "Apple Watch", "Milk", "Beef", "Steak", "Cheeze"]
    var filteredArray = [String]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Find company or ticker"
        searchController.searchBar.delegate = self
    }
}

extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredArray.count
        } else {
            return tempArray.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var device: String?
        if isSearching {
            device = filteredArray[indexPath.row]
        } else {
            device = tempArray[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SnippetCell
        cell.textLabel?.text = device
//        cell.snippet = snippets?[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        } else {
            isSearching = true
            filteredArray = tempArray.filter {$0.range(of: searchBar.text!, options: .caseInsensitive) != nil }
            tableView.reloadData()
        }
    }
}
