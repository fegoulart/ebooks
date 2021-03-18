//
//  ViewController.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

import UIKit

protocol ListingDisplayLogic: AnyObject {
    func displayListing(viewModel: ListingPage.FetchEBooks.ViewModel)
}

final class ListingViewController:
    UIViewController,
    ListingDisplayLogic,
    UITableViewDelegate,
    UITableViewDataSource {

    var interactor: ListingBusinessLogic?
    var displayedEBooks: [ListingPage.DisplayedShortEBook] = []
    let cellReuseIdentifier = "ebookCell"

    @IBOutlet var listingTableView: UITableView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
        fetchEBooks()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

// MARK: Setup
extension ListingViewController {

    func setup() {
        let viewController = self
        let interactor = ListingInteractor()
        let presenter = ListingPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    func setupUI() {
        setupTableView()
    }

    private func setupTableView() {
        self.listingTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        listingTableView.delegate = self
        listingTableView.dataSource = self
    }
}

// MARK: TableView

extension ListingViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedEBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell? =
            self.listingTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?
        cell?.textLabel?.text = self.displayedEBooks[indexPath.row].title
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

}

// MARK: Actions

extension ListingViewController {

    func fetchEBooks() {
        let request = ListingPage.FetchEBooks.Request(term: "swift")
        interactor?.fetchTerm(request: request)
    }

    func displayListing(viewModel: ListingPage.FetchEBooks.ViewModel) {
        setupListingDisplay(viewModel: viewModel)
    }

    private func setupListingDisplay(viewModel: ListingPage.FetchEBooks.ViewModel) {
        guard viewModel.error == nil else {
            Alert.showUnableToRetrieveDataAlert(on: self)
            return
        }
        displayedEBooks = viewModel.displayedShortEBooks
        listingTableView.reloadData()
    }
}
