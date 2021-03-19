//
//  SingleEBookInteractor.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

protocol SingleEBookBusinessLogic {
    func getEBook(request: SingleEBookPage.GetEBook.Request)
}

protocol SingleEBookDataStore {
    var eBook: EBook? { get set }
}

class SingleEBookInteractor: SingleEBookBusinessLogic, SingleEBookDataStore {

    var presenter: SingleEBookPresentationLogic?
    var eBook: EBook?

    func getEBook(request: SingleEBookPage.GetEBook.Request) {
        guard let eBook = eBook else { return }
        let response = SingleEBookPage.GetEBook.Response(eBook: eBook)
        presenter?.presentSingleEBook(response: response)
    }
}
