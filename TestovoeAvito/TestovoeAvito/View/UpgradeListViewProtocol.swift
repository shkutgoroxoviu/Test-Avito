//
//  UpgradeListViewProtocol.swift
//  TestovoeAvito
//
//  Created by Oleg on 18.06.2023.
//

import Foundation

protocol UpgradeListViewProtocol: AnyObject {
    func reloadData()
    func config(model: Response)
}
