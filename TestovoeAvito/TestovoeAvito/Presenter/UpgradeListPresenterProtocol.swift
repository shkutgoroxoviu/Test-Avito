//
//  UpgradeListPresenterProtocol.swift
//  TestovoeAvito
//
//  Created by Oleg on 18.06.2023.
//

import Foundation
 
protocol UpgradeListPresenterProtocol: AnyObject {
    var response: Response? { get set }
    
    var list: [ListItem] { get set }
    
    func viewDidLoad()
    
    func builderForCell(list: ListItem) -> UpgradeListModel
}
