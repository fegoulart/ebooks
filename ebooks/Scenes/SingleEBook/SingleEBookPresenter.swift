//
//  SingleEBookPresenter.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import Foundation

protocol SingleEBookPresentationLogic {
    func presentSingleEBook(response: SingleEBookPage.GetEBook.Response)
}

final class SingleEBookPresenter: SingleEBookPresentationLogic {
    weak var viewController: SingleEBookDisplayLogic?
    func presentSingleEBook(response: SingleEBookPage.GetEBook.Response) {
        let eBook = response.eBook
        let displayedEBook = SingleEBookPage.GetEBook.ViewModel.DisplayedEBook(
            author: eBook.artistName,
            artworkUrl60: eBook.artworkUrl60,
            artworkUrl100: eBook.artworkUrl100,
            averageUserRating: eBook.averageUserRating,
            currency: eBook.currency,
            description: eBook.description?.fromHtml() ?? "",
            formattedPrice: eBook.formattedPrice,
            releaseDate: eBook.releaseDate,
            trackId: eBook.trackId,
            title: eBook.trackName?.fromHtml() ?? "",
            userRatingCount: eBook.userRatingCount)
        let viewModel = SingleEBookPage.GetEBook.ViewModel(displayedEBook: displayedEBook)
        viewController?.displaySingleEBook(viewModel: viewModel)
    }
}
