//
//  SingleEBookRouter.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

import UIKit

@objc protocol SingleEBookRoutingLogic {
}

protocol SingleEBookDataPassing {
  var dataStore: SingleEBookDataStore? { get }
}

class SingleEBookRouter: NSObject, SingleEBookRoutingLogic, SingleEBookDataPassing, RouterProtocol {

  weak var viewController: SingleEBookViewController?
  var dataStore: SingleEBookDataStore?

}
