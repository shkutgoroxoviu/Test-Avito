//
//  UpgradeListPresenter.swift
//  TestovoeAvito
//
//  Created by Oleg on 18.06.2023.
//

import Foundation

class UpgradeListPresenter: UpgradeListPresenterProtocol {
    weak var view: UpgradeListViewProtocol?
    var interactor: UpgradeListInteractorProtocol?
    
    var response: Response?
    var list: [ListItem] = [ListItem]()
    
    func viewDidLoad() {
        interactor?.startFetch()
        guard let response = response else { return }
        view?.config(model: response)
        view?.reloadData()
    }
    
    func builderForCell(list: ListItem) -> UpgradeListModel {
        return UpgradeListModel(upgradeName: list.title, icon: list.icon.iconUrl, description: list.description, price: list.price)
    }
}
