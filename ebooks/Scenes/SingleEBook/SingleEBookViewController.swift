//
//  SingleEBookViewController.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import UIKit

protocol SingleEBookDisplayLogic: AnyObject {
    func displaySingleEBook(viewModel: SingleEBookPage.GetEBook.ViewModel)
}

final class SingleEBookViewController:
    UIViewController,
    SingleEBookDisplayLogic {

    var interactor: SingleEBookBusinessLogic?
    var router: (NSObjectProtocol & SingleEBookRoutingLogic & SingleEBookDataPassing)?

    @IBOutlet weak var eBookCoverImageView: UIImageView!
    @IBOutlet weak var eBookDescriptionLabel: UILabel!

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
        getEBook()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
}

// MARK: Setup
extension SingleEBookViewController {

    func setup() {
        let viewController = self
        let interactor = SingleEBookInteractor()
        let presenter = SingleEBookPresenter()
        let router = SingleEBookRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    func setupUI() {
    }
}

// MARK: Actions

extension SingleEBookViewController {

    func getEBook() {
        let request = SingleEBookPage.GetEBook.Request()
        interactor?.getEBook(request: request)
    }

    func displaySingleEBook(viewModel: SingleEBookPage.GetEBook.ViewModel) {
        title =  viewModel.displayedEBook.title
        self.eBookCoverImageView.download(image: viewModel.displayedEBook.artworkUrl100 ?? "")
        self.eBookDescriptionLabel.text = viewModel.displayedEBook.description
    }
}
