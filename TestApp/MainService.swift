//
//  MainService.swift
//  TestApp
//
//  Created by Hadi Faturrahman on 20/05/21.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case decodingError
}

class MainService {
    
    var defaulParams: [String: Any] = [
        "units": "metric",
        "lang": "id",
        "appid": "bdcf3c2c704c58be9359d99c0c547368"
    ]
    
    func get<T: Codable>(
        url: String = "https://api.openweathermap.org/data/2.5/weather",
        params: [String: Any],
        completion: @escaping (Result<T, Error>
    ) -> Void) {
        defaulParams.merge(dict: params)
        AF.request(
            url,
            method: .get,
            parameters: defaulParams
        ).responseData { response in
            let jsonDecoder = JSONDecoder()
            let model = try? jsonDecoder.decode(T.self, from: response.data ?? Data())
            if let result = model {
                completion(.success(result))
            } else {
                completion(.failure(NetworkError.decodingError))
            }
        }
    }
}

extension Dictionary {
    mutating func merge(dict: [Key: Value]){
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }
}

