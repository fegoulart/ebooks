//
//  SearchModel.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

enum SearchPage {

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

    struct DisplayedTrending {
        var title: String
    }
    // swiftlint:disable nesting
    enum FetchEBooks {
        struct Request {
            var term: String
            var isTest: Bool = false
        }

        struct Response {
            var eBooks: [EBook]?
            var error: SearchError?
        }

        struct ViewModel {
            var displayedEBooks: [DisplayedEBook]
            var error: SearchError?
        }
    }

    enum SaveTrending {
        struct Request {
            var term: String
            var isTest: Bool = false
        }

        struct Response {
            var error: SearchError?
        }

        struct ViewModel {
            var error: SearchError?
        }
    }

    enum GetTrendings {
        struct Request {
        }

        struct Response {
            var trendings: [String]?
            var error: SearchError?
        }

        struct ViewModel {
            var displayedTrendings: [DisplayedTrending]
            var error: SearchError?
        }
    }
    // swiftlint:enable nesting
}
