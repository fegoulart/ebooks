//
//  CustomNetworkErrors.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 16/03/21.
//

public enum CleanNetworkError: Error {
    case noInternet
    case badAPIRequest
    case unauthorized
    case unknown
}
