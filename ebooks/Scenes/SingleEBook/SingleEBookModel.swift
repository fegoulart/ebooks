//
//  SingleEBookModel.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

enum SingleEBookPage {

    struct DisplayedEBook {
        var author: String?
        var artworkUrl60: String?
        var artworkUrl100: String?
        var averageUserRating: Float?
        var currency: String?
        var description: String?
        var formattedPrice: String?
        var releaseDate: String?
        var trackId: Int?
        var title: String?
        var userRatingCount: Int?
    }
    
    struct ViewModel {
        var displayedEBook: DisplayedEBook
        var error: SingleEBookError?
    }

}

