//
//  SingleEBookInteractor.swift
//  ebooks
//
//  Created by Fernando Luiz Goulart on 18/03/21.
//

protocol SingleEBookBusinessLogic {
    
}

protocol SingleEBookDataStore {
    var eBook: EBook? { get set }
}

class SingleEBookInteractor: SingleEBookBusinessLogic, SingleEBookDataStore {
    var presenter: SingleEBookPresentationLogic?
    var worker = SingleEBookWorker()
    var eBook: EBook?
}

