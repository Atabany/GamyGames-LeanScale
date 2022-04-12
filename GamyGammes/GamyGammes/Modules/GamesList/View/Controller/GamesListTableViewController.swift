//
//  GamesListTableViewController.swift
//  GamyGammes
//
//  Created by Mohamed Elatabany on 11/04/2022.
//

import UIKit

import UIKit
class GamesListTableViewController: UIViewController {

    let tableView = UITableView()
    var searchController: UISearchController!
    let emptyStateLabel = UILabel()
    var activityIndicator = UIActivityIndicatorView()
    
    var viewModel: GamesListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        if let _ = viewModel.gamesListScreen as? FavoriteGames {
            viewModel.initFetch()
        }
    }
    
}


extension GamesListTableViewController {
    private func setup() {
        if viewModel.canSearch {
            configureSearchController()
        }
        navigationItem.title = viewModel.navBarTitle.value
        initVM()
        setupTableView()
    }



    
    func configureSearchController() {
        searchController                                       = UISearchController()
        searchController.searchResultsUpdater                  = self
        searchController.searchBar.placeholder                 = Constants.Strings.searchForTheGame
        searchController.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                        = searchController
        navigationItem.hidesSearchBarWhenScrolling             = false
    }
    
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = self.view.bounds
        tableView.register(GameTableCell.self, forCellReuseIdentifier: GameTableCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

//MARK: - View Model - Binding & init

extension GamesListTableViewController {
    func initVM() {
        
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.showAlertWithHandlerClosure = { [weak self] () in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if let message = self.viewModel.alertWithHandlerMessage {
                    self.showAlert( message ) { _ in
                        self.viewModel.alertHandlerAction()
                    }
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
            let detailsViewController = GameDetailsViewController(viewModel: GameDetailsViewModel(service: GamesDetailsWebService(), selectedGame: self.viewModel.selectedGame))
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        }
        
        viewModel.navBarTitle.bind { [weak self] title in
            guard let self = self else {return}
            self.navigationItem.title = title
        }
        
        viewModel.initFetch()
        
    }
}



//MARK: -  Style
extension GamesListTableViewController {
    private func style() {
        view.backgroundColor = AppTheme.shared.gamesBackgroundColor
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .systemBackground
        } else {
            tableView.backgroundColor = .white
        }
        
        styleActivityIndicator()
        styleEmptyStateLabel()
    }
    
    private func styleActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator =  UIActivityIndicatorView(style: .large)
        }
    }
    
    private func styleEmptyStateLabel() {
        emptyStateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        emptyStateLabel.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.91
        emptyStateLabel.attributedText = NSMutableAttributedString(string: viewModel.emptyMessage, attributes: [NSAttributedString.Key.kern: 0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }
    
}

//MARK: -  Layout
extension GamesListTableViewController {
    
    private func layout() {
        layoutEmptyStateLabel()
        layoutActivityIndicator()
    }
    
    
    
    private func layoutEmptyStateLabel() {
        view.addSubview(emptyStateLabel)
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyStateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    
 
    
    
    private func layoutActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
        viewModel.deleteFavoriteAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return viewModel.canDelete ? .delete : .none
    }
}


extension GamesListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, (filter.count > 3) else {
            return
        }
        viewModel.search(filter: filter)
    }
}


//MARK: -  Pagination
extension GamesListTableViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            self.viewModel.loadMore()
        }
    }
}


