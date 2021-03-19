//
//  SearchRouter.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import UIKit

@objc protocol SearchRoutingLogic {
    func showListingPage()
}

protocol SearchDataPassing {
  var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing, RouterProtocol {

  weak var viewController: SearchViewController?
  var dataStore: SearchDataStore?

  // MARK: Routing
    func showListingPage() {
        let eBooks = dataStore?.eBooks ?? []
        if (eBooks.isEmpty) {
            if let currentVc : SearchViewController = viewController {
                Alert.showBasicAlert(on: currentVc, with: "Not found", message: "No results found")
            }
        }
        show(nibIdentifier: "ListingViewController") { (destinationVC: ListingViewController) in
            if var destinationDS: ListingDataStore = destinationVC.router?.dataStore {
                self.passDataToEBookPage(source: eBooks, destination: &destinationDS)
            }
        }
    }

    // MARK: Passing data
    func passDataToEBookPage(source: [EBook], destination: inout ListingDataStore) {
        destination.eBooks = source
    }
}
