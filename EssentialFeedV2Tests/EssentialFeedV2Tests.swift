//
//  EssentialFeedV2Tests.swift
//  EssentialFeedV2Tests
//
//  Created by Jaavion Davis on 3/28/24.
//
import XCTest
import Foundation
import EssentialFeedV2
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
        // now if we want to make singletons testable we can create a mutable instance
        
        // remember a client who is requesting a reaction from a host
        let(sut, client) = makeSUT()
        // when
        
        // expect
        XCTAssertNil(client.requestedURL)
        
    }
        // now we want to check and see if we are getting data from the requested URL
    
    func test_load_requestDataFromURL() {
        // we can see theres a bunch of code repeating here
        // how about what we make a factory pattern
        // given
        let (sut, client) = makeSUT()
        // when
        // we are using method injection here and each has there pros and cons
        sut.load(from: URL(string: "https://amazon.com")!)
        
        // assert
        
        XCTAssertNotNil(client.requestedURL)
    }
    
    // we can use a helper function because its a set of instructions to write more clean code and create more reusable code
    private func makeSUT()->(RemoteFeedLoader, HTTPClientSpy) {
        // the system under test is the higher implementation
        let client: HTTPClientSpy = HTTPClientSpy()
        let sut: RemoteFeedLoader = RemoteFeedLoader(client: client)
        
        // now remmeber we have to have the same instances right thats the beautiful things about classes and objects
        return (sut, client)
    }
    //
}
// lets test out the Singleton foor this approach
// lets remember to create meaningful Names
// what is the responsibility of this lower level class its to grab data which could considered a HTTPClient <--- remember this will always be a noun


// remember this is the D in dependency injection
// where we want to have an implementation object and we interface that way our code doesn't break in the instance we don't create a changes
// well we don't want to use our main system to share because this can conflict with productioon testing data
// we shouldn't mix our production system with testing system
// well we know every time that our will need a get operation to fetch data
// we only want one instance of this object
 

// The D in SOLID Principles states we should have a higher module and lower level module one for the implementation
// we want to implement the get fucntion to fetch data for all of clients that are fetchinh
// we should have multiple clients or maybe just one client that does one thing

// but to avoid inheritance chainning which can have effects on
// so lets incorporate a contract that says you must implement this feature its very lightweight
final class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
   func get(from url: URL) {
        requestedURL = url
    }
}



