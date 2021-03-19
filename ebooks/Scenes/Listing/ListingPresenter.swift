//
//  ListingPresentationLogic.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

protocol ListingPresentationLogic {
    func presentListing(response: ListingPage.FetchEBooks.Response)
}

final class ListingPresenter: ListingPresentationLogic {
    weak var viewController: ListingDisplayLogic?
    func presentListing(response: ListingPage.FetchEBooks.Response) {
        let displayedEBooks = getDisplayedEBooks(response.eBooks)
        let viewModel = ListingPage.FetchEBooks.ViewModel(displayedEBooks: displayedEBooks, error: nil)
        viewController?.displayListing(viewModel: viewModel)
    }
}

extension ListingPresenter {
    private func getDisplayedEBooks(_ eBooksToDisplay: [EBook]?) -> [ListingPage.DisplayedEBook] {
        var displayedEBooks: [ListingPage.DisplayedEBook] = []
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
                    ListingPage.DisplayedEBook(
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
