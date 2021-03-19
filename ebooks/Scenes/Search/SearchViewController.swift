//
//  SearchViewController.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displaySearch(viewModel: SearchPage.FetchEBooks.ViewModel)
    func displayTrendings(viewModel: SearchPage.GetTrendings.ViewModel)
    func displaySaveTrending(viewModel: SearchPage.SaveTrending.ViewModel)
}

final class SearchViewController:
    UIViewController,
    SearchDisplayLogic,
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchBarDelegate {

    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    var displayedTrendings: [SearchPage.DisplayedTrending] = []
    let cellReuseIdentifier = "trendingCell"
    let cellNibName = "TrendingTableViewCell"

    @IBOutlet weak var eBookSearchBar: UISearchBar!
    @IBOutlet weak var trendingTableView: UITableView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getTrendings()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

// MARK: Setup
extension SearchViewController {

    func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    func setupUI() {
        title = ""
        setupTableView()
        setupSearchBar()
    }

    private func setupTableView() {
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
    }

    private func setupSearchBar() {
        eBookSearchBar.delegate = self
    }
}

// MARK: TableView

extension SearchViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedTrendings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            self.trendingTableView.dequeueReusableCell(
                withIdentifier: cellReuseIdentifier)
        cell?.textLabel?.text = displayedTrendings[indexPath.row].title
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}

// MARK: SearchBar

extension SearchViewController {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let term = searchBar.text else { return }
        if (term != "") {
            self.fetchEBooks(term: term)
        }
    }
}

// MARK: Actions

extension SearchViewController {

    func getTrendings() {
        let request = SearchPage.GetTrendings.Request()
        interactor?.getTrendings(request: request)
    }

    func fetchEBooks(term: String) {
        let request = SearchPage.FetchEBooks.Request(term: term)
        interactor?.fetchTerm(request: request)
    }

    func displaySearch(viewModel: SearchPage.FetchEBooks.ViewModel) {
        router?.showListingPage()
    }

    func displayTrendings(viewModel: SearchPage.GetTrendings.ViewModel) {
        setupTrendingsDisplay(viewModel: viewModel)
    }

    private func setupTrendingsDisplay(viewModel: SearchPage.GetTrendings.ViewModel) {
        guard viewModel.error == nil else {
            Alert.showUnableToRetrieveDataAlert(on: self)
            return
        }
        displayedTrendings = viewModel.displayedTrendings
        trendingTableView.reloadData()
    }

    func displaySaveTrending(viewModel: SearchPage.SaveTrending.ViewModel) {
        guard viewModel.error != nil else { return }
        Alert.showBasicAlert(on: self, with: "Error", message: "Could not save term as trending")
    }
}
