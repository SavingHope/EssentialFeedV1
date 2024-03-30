//
//  RemoteFeedLoader.swift
//  EssentialFeedV2
//
//  Created by Jaavion Davis on 3/30/24.
//

import Foundation

open class RemoteFeedLoader {
    // we can use dependence injection for this that we can have a component and not have to break the entire code
   private let client: HTTPClient
   private let url: URL
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    // the responsibility of this function will be to
    public func load() {
        client.get(from: url)
    }
}
