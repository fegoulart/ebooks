//
//  ListingInteractor.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

protocol ListingBusinessLogic {
    func fetchTerm(request: ListingPage.FetchEBooks.Request)
}

protocol ListingDataStore {
    var eBooks: EBooks? { get }
}

class ListingInteractor: ListingBusinessLogic, ListingDataStore {
    var presenter: ListingPresentationLogic?
    var worker = ListingWorker()
    var eBooks: EBooks?

    func fetchTerm(request: ListingPage.FetchEBooks.Request) {
        var response: ListingPage.FetchEBooks.Response!
        self.worker.eBookDataManager.getEBooks(from: request.term).done { eBooks in
            var newEBooks: [EBook] = []
            for eBook in eBooks.results ?? [] {
                newEBooks.append(eBook)
            }
            response = ListingPage.FetchEBooks.Response(eBooks: newEBooks, error: nil)
        }.catch { error in
            response = ListingPage.FetchEBooks.Response(
                eBooks: nil,
                error: ListingError.couldNotFetchEBooks(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentListing(response: response)
        }
    }
}
