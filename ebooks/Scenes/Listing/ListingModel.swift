//
//  ListingModels.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

enum ListingPage {

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
    // swiftlint:disable nesting
    enum GetEBooks {
        struct Request {
            var isTest: Bool = false
        }

        struct Response {
            var eBooks: [EBook]?
            var error: ListingError?
        }

        struct ViewModel {
            var displayedEBooks: [DisplayedEBook]
            var error: ListingError?
        }
    }
    // swiftlint:enable nesting
}
