//
//  RemoteFeedLoader.swift
//  EssentialFeedV2
//
//  Created by Jaavion Davis on 3/30/24.
//

import Foundation

open class RemoteFeedLoader {
    // we can use dependence injection for this that we can have a component and not have to break the entire code
    // we need to express different states of what's happening
    
    // in the concept of this scope its called an error not http client error
    // the contract says that it conforms so its of the same type
   public enum Error: Swift.Error {
       case connectivity
    }
   private let client: HTTPClient
   private let url: URL
    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }
    // the responsibility of this function will be to
    // to avoid breaking we should consider giving a default value
    public func load(_ completionHandler: @escaping (Error) -> Void = { _ in }) {
        // this is the implementation
        client.get(from: url) { error  in
            // the completion handler and it conforms to the error protocol so we can pass in a error
            // okay the enum is of  protocol so what we can do is say
            // we are essentially stubbing the value
            completionHandler(.connectivity)
        }
    }
}
