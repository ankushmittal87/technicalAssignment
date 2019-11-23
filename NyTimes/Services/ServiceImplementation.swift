//
//  ServiceImplementation.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import Foundation
// Can be extended with generics as and when required.
typealias Completion = ((Swift.Result<MostViewed, NYTimesError>) -> Void)

protocol NetworkClient {
    func get(with url: URL, completion :@escaping Completion)
}

class ServiceImplementation: NetworkClient {
    func get(with url: URL, completion: @escaping Completion) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let mostViewdArcticles = try decoder.decode(MostViewed.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(mostViewdArcticles))
                    }
                } catch {
                    let error: NYTimesError = NYTimesError.noValidResponse
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                let error: NYTimesError = NYTimesError.error(code: 10,
                                                             message: error?.localizedDescription ?? "Server error occured")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            }.resume()
    }
}
enum NYTimesError: Error {
    case error(code: Int, message: String)
    case noValidResponse
    var localizedDescription: String {
        switch self {
        case .error(_, let message):
            return message
        case .noValidResponse:
            return "No valid response received from the server"
        }
    }
}
