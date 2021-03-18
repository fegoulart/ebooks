//
//  SingleEBookModel.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

enum SingleEBookPage {

    // swiftlint:disable nesting
    enum GetEBook {

        struct Request {
        }

        struct Response {
            var eBook : EBook
        }

        struct ViewModel {
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

            var displayedEBook: DisplayedEBook
        }
    }
}
