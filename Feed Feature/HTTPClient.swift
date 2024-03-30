//
//  HTTPClient.swift
//  EssentialFeedV2
//
//  Created by Jaavion Davis on 3/30/24.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}
