//
//  SingleEBookPresenter.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

protocol SingleEBookPresentationLogic {
    func presentSingleEBook(viewModel: SingleEBookPage.ViewModel)
}

final class SingleEBookPresenter: SingleEBookPresentationLogic {
    weak var viewController: SingleEBookDisplayLogic?
    func presentSingleEBook(viewModel: SingleEBookPage.ViewModel) {
        viewController?.displaySingleEBook(viewModel: viewModel)
    }
}

