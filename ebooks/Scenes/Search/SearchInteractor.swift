//
//  SearchInteractor.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

protocol SearchBusinessLogic {
    func fetchTerm(request: SearchPage.FetchEBooks.Request)
    func getTrendings(request: SearchPage.GetTrendings.Request)
    func saveTrending(request: SearchPage.SaveTrending.Request)
}

protocol SearchDataStore {
    var eBooks: [EBook]? { get }
    var trendings: [String]? { get }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var presenter: SearchPresentationLogic?
    var worker = SearchWorker()
    var trendingWorker = SearchTrendingWorker()
    var eBooks: [EBook]?
    var trendings: [String]?

    func fetchTerm(request: SearchPage.FetchEBooks.Request) {
        var response: SearchPage.FetchEBooks.Response!
        self.worker.eBookDataManager.getEBooks(from: request.term).done { receivedEBooks in
            var newEBooks: [EBook] = []
            for eBook in receivedEBooks.results ?? [] {
                newEBooks.append(eBook)
            }
            self.eBooks = newEBooks
            response = SearchPage.FetchEBooks.Response(eBooks: self.eBooks, error: nil)

        }.catch { error in
            response = SearchPage.FetchEBooks.Response(
                eBooks: nil,
                error: SearchError.couldNotFetchEBooks(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentSearch(response: response)
        }
    }

    func getTrendings(request: SearchPage.GetTrendings.Request) {
        var response: SearchPage.GetTrendings.Response!
        self.trendingWorker.trendingDataManager.getTrendings().done { receivedTrendings in
            var newTrendings: [String] = []
            for trending in receivedTrendings {
                newTrendings.append(trending)
            }
            self.trendings = newTrendings
            response = SearchPage.GetTrendings.Response(trendings: self.trendings, error: nil)

        }.catch { error in
            response = SearchPage.GetTrendings.Response(
                trendings: nil,
                error: SearchError.couldNotGetTrendings(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentTrendings(response: response)
        }
    }

    func saveTrending(request: SearchPage.SaveTrending.Request) {
        var response: SearchPage.SaveTrending.Response!
        self.trendingWorker.trendingDataManager.saveTrending(term: request.term).done { _ in
            response = SearchPage.SaveTrending.Response(error: nil)
        }.catch { error in
            response = SearchPage.SaveTrending.Response(
                error: SearchError.couldNotSaveTrending(error: error.localizedDescription))
        }.finally {
            self.presenter?.presentSaveTrending(response: response)
        }
    }
}
