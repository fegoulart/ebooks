//
//  ListingRouter.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import UIKit

@objc protocol ListingRoutingLogic {
    func showEBookPage(for id: Int)
}

protocol ListingDataPassing {
  var dataStore: ListingDataStore? { get }
}

class ListingRouter: NSObject, ListingRoutingLogic, ListingDataPassing, RouterProtocol {

  weak var viewController: ListingViewController?
  var dataStore: ListingDataStore?

  // MARK: Routing

    func showEBookPage(for id: Int) {
        let selectedEBook = dataStore?.eBooks?.first { $0.trackId == id }
        guard let eBook = selectedEBook else { return }

        show(nibIdentifier: "SingleEBookViewController") { (destinationVC: SingleEBookViewController) in
            var destinationDS: SingleEBookDataStore =
                destinationVC.router!.dataStore!
                as! SingleEBookDataStore
            self.passDataToEBookPage(source: eBook, destination: &destinationDS)
        }
    }

    // MARK: Passing data

    func passDataToEBookPage(source: EBook, destination: inout SingleEBookDataStore) {
        destination.eBook = source
    }
}
