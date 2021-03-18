//
//  ListingModels.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

enum ListingPage {

    struct DisplayedShortEBook {
        var artworkUrl: String
        var title: String
        var author: String
        var trackId: Int
    }
    // swiftlint:disable nesting
    enum FetchEBooks {
        struct Request {
            var term: String
            var isTest: Bool = false
        }

        struct Response {
            var eBooks: [EBook]?
            var error: ListingError?
        }

        struct ViewModel {
            var displayedShortEBooks: [DisplayedShortEBook]
            var error: ListingError?
        }
    }
    // swiftlint:enable nesting
}
