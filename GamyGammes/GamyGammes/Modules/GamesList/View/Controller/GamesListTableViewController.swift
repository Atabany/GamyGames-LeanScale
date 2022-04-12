//
//  GamesListTableViewController.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit

class GamesListTableViewController: UIViewController {
    
    let tableView = UITableView()
    var searchController: UISearchController!
    let emptyStateLabel = UILabel()
    var activityIndicator = UIActivityIndicatorView()
    
    var viewModel: GamesListViewModel = GamesListViewModel(apiService: GamesListWebService())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }
    
    
    
    private func configureVC() {
        styleEmptyStateLabel()
        layoutEmptyStateLabel()
        
        view.backgroundColor = AppTheme.shared.gamesBackgroundColor
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        title = viewModel.navBarTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        configureSearchController()
        styleActivityIndicator()
        layoutActivityIndicator()
        initVM()
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
    
    
    private func styleEmptyStateLabel() {
        emptyStateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        emptyStateLabel.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.91
        emptyStateLabel.attributedText = NSMutableAttributedString(string: "No game has been searched.", attributes: [NSAttributedString.Key.kern: 0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
    
    private func layoutEmptyStateLabel() {
        
        view.addSubview(emptyStateLabel)
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyStateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
    private func styleActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator =  UIActivityIndicatorView(style: .large)
        }
    }
    
    
    private func layoutActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    
    func initVM() {
        
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                        self.emptyStateLabel.alpha = 0.0
                    })
                case .populated:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        
        viewModel.showDetails = { [weak self] () in
            guard let self = self else {return}
            let detailsViewController = GameDetailsViewController()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        }

        
        viewModel.initFetch()
        
    }
    
    
        
}


//MARK: -  TableView Data source & delegate
extension GamesListTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return GameTableCell.rowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsIn(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableCell.reuseId, for: indexPath) as? GameTableCell else {return UITableViewCell()}
        if let viewModel = viewModel.gameViewModelAt(indexPath: indexPath) {
            cell.updateUI(with: viewModel)
        }
        return cell
    }
}


extension GamesListTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectViewModel(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
    }
}


extension GamesListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        
        
    }
}



