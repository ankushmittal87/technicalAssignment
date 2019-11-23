//
//  WebserviceManager.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import Foundation
class WebserviceManager: NSObject {
    public static let shared = WebserviceManager()
    private let apiClient: NetworkClient  = ServiceImplementation()
    private var components = URLComponents()
    override init() {
        components.scheme = "https"
        components.host = "api.nytimes.com"
        
    }
    private func formURL(period: Int, apikey key: String) -> URL? {
        components.path = #"/svc/mostpopular/v2/viewed/\#(period).json"#
        components.queryItems = [
            URLQueryItem(name: "api-key", value: key)
        ]
        return components.url
    }
    func loadMostViewedArcticles(period: Int, completion: @escaping Completion) {
        let url = formURL(period: period, apikey: Keys.nyKey)
        guard let safeURL = url else {
            print("Not a valid url")
            return
        }
        apiClient.get(with: safeURL, completion: completion)
    }
}

enum WebServiceError: Error {
    case badURL
}

