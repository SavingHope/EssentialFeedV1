//
//  HTTPClient.swift
//  EssentialFeedV2
//
//  Created by Jaavion Davis on 3/30/24.
//

import Foundation

// this need to adhere because this the contract
public protocol HTTPClient {
    func get(from url: URL, handler: @escaping (Error)-> Void)
}
