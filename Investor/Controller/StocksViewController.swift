//
//  StocksViewController.swift
//  Investor
//
//  Created by chiwawa on 28.03.2021.
//

import UIKit

class StocksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private var filteredSnippets = [Snippet]()
    
    private var snippets: [Snippet]?
    
    private func fetchSnippets() {
        
        ApiService().fetchSnippets { (snippets: [Snippet]) in
            self.snippets = snippets
            DispatchQueue.main.async {
                self.tableView?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSnippets()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        
        self.navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Find company or ticker"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
    }
}

extension StocksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredSnippets.count
        }
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SnippetCell
        
        if isFiltering {
            cell.snippet = filteredSnippets[indexPath.row]
        } else {
            cell.snippet = snippets?[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension StocksViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        if let snippets = snippets {
            
            filteredSnippets = snippets.filter({ (snippet: Snippet) -> Bool in
                
                if let symbol = snippet.symbol,
                   let longName = snippet.longName {
                    
                    return symbol.lowercased().contains(searchText.lowercased()) ||
                            longName.lowercased().contains(searchText.lowercased())
                }
                return false
            })
        }
        tableView.reloadData()
    }
}
