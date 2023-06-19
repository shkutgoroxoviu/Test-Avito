//
//  UpgradeListInteractor.swift
//  TestovoeAvito
//
//  Created by Oleg on 18.06.2023.
//

import Foundation

class UpgradeListInteractor: UpgradeListInteractorProtocol {
    weak var presenter: UpgradeListPresenterProtocol?
    
    var networkService = NetworkService()
    
    func startFetch() {
        self.networkService.fetchList { [weak self] model in
            self?.presenter?.response = model
            self?.presenter?.list = model.result.list
        }
        
    }
}
