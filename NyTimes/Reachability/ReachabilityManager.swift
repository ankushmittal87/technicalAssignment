//
//  ReachabilityManager.swift
//  NyTimes
//
//  Created by Ankush Mittal on 20/11/19.
//  Copyright © 2019 Ankush Mittal. All rights reserved.
//

import Foundation
import Reachability
protocol ReachibilityListeners: class {
    func internetStatus(status: InternetStatus)
}
class ReachabilityManager: NSObject {
    static let shared = ReachabilityManager()
    var delegates = [ReachibilityListeners]()
    let reachability = try! Reachability()
    private override init() {}
    func startMonitoring() {
        reachability.whenUnreachable = { [weak self]  _ in
            guard let self = self else {
                return
            }
            for listener in self.delegates {
                listener.internetStatus(status: .unAvailable)
            }
        }
        reachability.whenReachable = { [weak self] reach in
            guard let self = self else {
                return
            }
            for listener in self.delegates {
                listener.internetStatus(status: .available)
            }
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Reachbility is not wokring")
        }
    }
    func stopMonitoring() {
        reachability.stopNotifier()
    }
    func addListener(listener: ReachibilityListeners)  {
        delegates.append(listener)
    }
    func removeListener(listener: ReachibilityListeners)  {
        delegates = delegates.filter{ $0 !== listener}
    }
}
enum InternetStatus {
    case available
    case unAvailable
}
