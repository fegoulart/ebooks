//
//  EBook.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

import Foundation

struct EBooks: Codable {
    let resultCount: Int?
    let results: [EBook]?
}

struct EBook: Codable {
    let artistId: Int?
    let artistName: String?
    let artworkUrl60: String?
    let artworkUrl100: String?
    let averageUserRating: Float?
    let currency: String?
    let description: String?
    let formattedPrice: String?
    let releaseDate: String?
    let trackId: Int?
    let trackName: String?
    let userRatingCount: Int?
}
