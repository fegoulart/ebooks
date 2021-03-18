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
    var router: (NSObjectProtocol & ListingRoutingLogic & ListingDataPassing)?
    var displayedEBooks: [ListingPage.DisplayedEBook] = []
    let cellReuseIdentifier = "ebookCell"
    let cellNibName = "EBookTableViewCell"

    @IBOutlet var listingTableView: UITableView!

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
        let router = ListingRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    func setupUI() {
        title = "In Your Library"
        setupTableView()
    }

    private func setupTableView() {
        self.listingTableView.register(
            UINib(nibName: cellNibName, bundle: nil),
            forCellReuseIdentifier: cellReuseIdentifier)
        listingTableView.delegate = self
        listingTableView.dataSource = self
        self.listingTableView.rowHeight = 100
    }
}

// MARK: TableView

extension ListingViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedEBooks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            self.listingTableView.dequeueReusableCell(
                withIdentifier: cellReuseIdentifier) as? EBookTableViewCell
        cell?.bookAuthorLabel.text = self.displayedEBooks[indexPath.row].author
        cell?.bookTitleLabel.text = self.displayedEBooks[indexPath.row].title
        cell?.bookCoverImageView.download(image: self.displayedEBooks[indexPath.row].artworkUrl60 ?? "")

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        guard let id = displayedEBooks[indexPath.row].trackId else { return }
        router?.showEBookPage(for: id)
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
