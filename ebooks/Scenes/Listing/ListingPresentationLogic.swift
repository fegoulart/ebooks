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
        let viewModel = ListingPage.FetchEBooks.ViewModel(displayedShortEBooks: displayedEBooks, error: nil)
        viewController?.displayListing(viewModel: viewModel)
    }
}

extension ListingPresenter {
    private func getDisplayedEBooks(_ eBooksToDisplay: [EBook]?) -> [ListingPage.DisplayedShortEBook] {
        var displayedEBooks: [ListingPage.DisplayedShortEBook] = []
        if let eBooks = eBooksToDisplay {
            for eBook in eBooks {
                let title = eBook.trackName
                let artworkUrl = eBook.artworkUrl60
                let author = eBook.artistName
                let displayedEBook =
                    ListingPage.DisplayedShortEBook(
                    artworkUrl: artworkUrl ?? "",
                    title: title ?? "",
                    author: author ?? "")
                displayedEBooks.append(displayedEBook)
            }
        }
        return displayedEBooks
    }
}
