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
   public init(client: HTTPClient) {
        self.client = client
    }
    // the responsibility of this function will be to
    public func load(from url: URL) {
        client.get(from: url)
    }
}
