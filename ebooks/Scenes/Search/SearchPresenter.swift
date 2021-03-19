//
//  SearchPresenter.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

protocol SearchPresentationLogic {
    func presentTrendings(response: SearchPage.GetTrendings.Response)
    func presentSaveTrending(response: SearchPage.SaveTrending.Response)
    func presentSearch(response: SearchPage.FetchEBooks.Response)
}

final class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?

    func presentTrendings(response: SearchPage.GetTrendings.Response) {
        let displayedTrendings = getDisplayedTrendings(response.trendings)
        let viewModel = SearchPage.GetTrendings.ViewModel(displayedTrendings: displayedTrendings, error: nil)
        viewController?.displayTrendings(viewModel: viewModel)
    }

    func presentSearch(response: SearchPage.FetchEBooks.Response) {
        let displayedEBooks = getDisplayedEBooks(response.eBooks)
        let viewModel = SearchPage.FetchEBooks.ViewModel(displayedEBooks: displayedEBooks, error: nil)
        viewController?.displaySearch(viewModel: viewModel)
    }

    func presentSaveTrending(response: SearchPage.SaveTrending.Response) {
        guard let error : SearchError = response.error else { return }
        let viewModel = SearchPage.SaveTrending.ViewModel(error: error )
        viewController?.displaySaveTrending(viewModel: viewModel)
    }
}

extension SearchPresenter {

    private func getDisplayedTrendings(_ trendingsToDisplay: [String]?) -> [SearchPage.DisplayedTrending] {
        var displayedTrendings: [SearchPage.DisplayedTrending] = []
        if let trendings = trendingsToDisplay {
            for trending in trendings {
                let displayedTrending = SearchPage.DisplayedTrending(title: trending)
                displayedTrendings.append(displayedTrending)
            }
        }
        return displayedTrendings
    }

    private func getDisplayedEBooks(_ eBooksToDisplay: [EBook]?) -> [SearchPage.DisplayedEBook] {
        var displayedEBooks: [SearchPage.DisplayedEBook] = []
        if let eBooks = eBooksToDisplay {
            for eBook in eBooks {
                let title = eBook.trackName?.fromHtml() ?? ""
                let artworkUrl60 = eBook.artworkUrl60
                let artworkUrl100 = eBook.artworkUrl100
                let author = eBook.artistName
                let trackId = eBook.trackId
                let averageUserRating = eBook.averageUserRating
                let currency = eBook.currency
                let description = eBook.description
                let formattedPrice = eBook.formattedPrice
                let releaseDate = eBook.releaseDate
                let userRatingCount = eBook.userRatingCount

                let displayedEBook =
                    SearchPage.DisplayedEBook(
                        author: author,
                        artworkUrl60: artworkUrl60,
                        artworkUrl100: artworkUrl100,
                        averageUserRating: averageUserRating,
                        currency: currency,
                        description: description,
                        formattedPrice: formattedPrice,
                        releaseDate: releaseDate,
                        trackId: trackId,
                        title: title,
                        userRatingCount: userRatingCount)
                displayedEBooks.append(displayedEBook)
            }
        }
        return displayedEBooks
    }
}
