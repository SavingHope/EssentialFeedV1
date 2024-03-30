//
//  EssentialFeedV2Tests.swift
//  EssentialFeedV2Tests
//
//  Created by Jaavion Davis on 3/28/24.
//
import XCTest
import Foundation
// we are going to test the system
// which could considered the controller
// also could be known as the Higher Level Abstraction
// first we want to test the implementation of the
// first things is when I click load I want to know that is grabbing data from the URL that I am pulling.
class RemoteFeedLoaderTest: XCTestCase {
    // now
    // we want to check and see if the client initalizing isn't automatically calling the test cases
    func test_init_doesNotRequestDataFromURL() {
        // we want to see if the changes we are doing actually have an impact
        // we will use the unit test case to define how to creat the interface it should be failing
        // given 
        let client: HTTPClient = HTTPClient()
        let _: RemoteFeedLoader = RemoteFeedLoader()
        // when
        
        // expect
        XCTAssertNil(client.requestedURL)
        
    }
        // now we want to check and see if we are getting data from the requested URL
    
    func test_load_requestDataFromURL() {
        // given
        let client: HTTPClient = HTTPClient()
        let sut: RemoteFeedLoader = RemoteFeedLoader()
        // when
        // we are using method injection here and each has there pros and cons
        sut.load(from: URL(string: "https://amazon.com")!)
        
        // assert
        
        XCTAssertNotNil(client.requestedURL)
        
        
        
    }
}

// lets test out the Singleton foor this approach
// lets remember to create meaningful Names
// what is the responsibility of this lower level class its to grab data which could considered a HTTPClient <--- remember this will always be a noun


// remember this is the D in dependency injection
// where we want to have an implementation object and we interface that way our code doesn't break in the instance we don't create a changes
class HTTPClient {
    static let shared: HTTPClient = HTTPClient()
    // we also want to check to see if its grabbing the URL
    // there may or may not be a url in this instance
    var requestedURL: URL?
    func get(from url: URL) {
        requestedURL = url
    }
}



class RemoteFeedLoader {
    // the responsibility of this function will be to
    func load(from url: URL) {
        HTTPClient.shared.get(from: url)
    }
}
