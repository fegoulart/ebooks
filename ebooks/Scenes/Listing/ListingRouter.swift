//
//  ListingRouter.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import UIKit

@objc protocol ListingRoutingLogic {
    func showEBookPage(for flightNumber: Int)
}

protocol ListingDataPassing {
  var dataStore: ListingDataStore? { get }
}

class ListingRouter: NSObject, ListingRoutingLogic, ListingDataPassing, RouterProtocol {

  weak var viewController: ListingViewController?
  var dataStore: ListingDataStore?

  // MARK: Routing

    func showEBookPage(for id: Int) {
        let selectedEBook = dataStore?.eBooks?.results?.first { $0.trackId == id }
        guard let EBook = selectedEBook else { return }

//        show(nibIdentifier: "SingleEBookPageViewController") { (destinationVC: SingleEBookPageViewController) in
//            var destinationDS = destinationVC.router!.dataStore!
//            self.passDataToEBookPage(source: EBook, destination: &destinationDS)
//        }
    }

    // MARK: Passing data

//    func passDataToEBookPage(source: EBook, destination: inout SingleEBookPageDataStore) {
//        destination.EBook = source
//    }
}
