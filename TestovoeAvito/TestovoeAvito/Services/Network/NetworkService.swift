//
//  NetworkService.swift
//  TestovoeAvito
//
//  Created by Oleg on 15.06.2023.
//

import Foundation
import SwiftyJSON

class NetworkService {
    func fetchList(complition: @escaping (Response) -> Void) {
        guard let path = Bundle.main.path(forResource: "AvitoList", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
         
            let decoder = JSONDecoder()
            let model = try decoder.decode(Response.self, from: data)
            complition(model)
            print(model.result.title)
        } catch {
            print(error)
        }
    }
    
    private func parseJson<T: Codable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        let model = try? decoder.decode(T.self, from: data)
        return model
    }
}
