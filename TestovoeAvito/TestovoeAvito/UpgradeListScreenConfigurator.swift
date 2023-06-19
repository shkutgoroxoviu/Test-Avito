//
//  UpgradeListScreenConfigurator.swift
//  TestovoeAvito
//
//  Created by Oleg on 18.06.2023.
//

import Foundation
import UIKit

class UpgradeListScreenConfigurator {
    static func createModule(using navigationController: UINavigationController) -> UIViewController {
        
        let presenter = UpgradeListPresenter()
        let interactor = UpgradeListInteractor()
        let view = UpgradeListViewController()
 
        presenter.interactor = interactor
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
}
