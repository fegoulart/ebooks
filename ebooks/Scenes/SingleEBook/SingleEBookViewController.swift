//
//  SingleEBookViewController.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import UIKit

protocol SingleEBookDisplayLogic: AnyObject {
    func displaySingleEBook(viewModel: SingleEBookPage.ViewModel)
}

final class SingleEBookViewController:
    UIViewController,
    SingleEBookDisplayLogic {

    var interactor: SingleEBookBusinessLogic?
    var router: (NSObjectProtocol & SingleEBookRoutingLogic & SingleEBookDataPassing)?
    var displayedEBook: SingleEBookPage.DisplayedEBook?

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
        title = "In Your Library"
        //TODO: Outlet here to download image

    }
}

// MARK: Actions

extension SingleEBookViewController {

    func displaySingleEBook(viewModel: SingleEBookPage.ViewModel) {
        setupSingleEBookDisplay(viewModel: viewModel)
    }

    private func setupSingleEBookDisplay(viewModel: SingleEBookPage.ViewModel) {
        guard viewModel.error == nil else {
            Alert.showUnableToRetrieveDataAlert(on: self)
            return
        }
        displayedEBook = viewModel.displayedEBook
    }
}
