//
//  GamesListTableViewController.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit

class GamesListTableViewController: UIViewController {

    let tableView = UITableView()
    var  searchController: UISearchController!

    var viewModel: GamesListViewModel = GamesListViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
        
    }
    
    
    private func configureVC() {
        view.backgroundColor = AppTheme.shared.gamesBackgroundColor
//        tableView.backgroundColor = .systemBackground
        title = "Games"
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        configureSearchController()
    }
    
    
    func configureSearchController() {
        searchController                                       = UISearchController()
        searchController.searchResultsUpdater                  = self
        searchController.searchBar.placeholder                 = "Search for the games"
        searchController.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                        = searchController
        navigationItem.hidesSearchBarWhenScrolling             = false
    }
    
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.register(GameTableCell.self, forCellReuseIdentifier: GameTableCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    
    
    private func fetchFavorites() {

    }

    
    
    
    private func updateEmptyState() {
        DispatchQueue.main.async {
            self.tableView.reloadData()


        }
    }
        
}


//MARK: -  TableView Data source & delegate
extension GamesListTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableCell.reuseId, for: indexPath) as? GameTableCell else {return UITableViewCell()}
        
        guard let gameViewModel = viewModel.gameViewModelAt(indexPath: indexPath) else {return UITableViewCell()}
//        cell.updateUI(with: weatherViewModel)
        return cell
    }
}


extension GamesListTableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {


    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}

    }
}


extension GamesListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {



    }
}

