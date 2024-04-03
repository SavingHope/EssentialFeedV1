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
        XCTAssertTrue(client.requestMessages.isEmpty)
        
    }
    
    func test_load_requestDeliversErrorOnClient() {
        // given
        // we want to assign the error here
        // we want to check to see if this will return us an error we can stub the behavior
        // remember we are checking to see whats inside of this state
        // we want to make sure that we are complying with the principle of spying because we don't want to just inject the controller with a expected data
        // we want to see how the system reacts
        // we can use arrays because its a dynamic data structure and it we are able to use the properties to check and see if the system is or function call is being invoked once
        
        var clientError: Error = NSError(domain: "Test", code: 0)
        var capturedErrors: [RemoteFeedLoader.Error] = []
        let (sut, client) =  makeSUT()
        // we can get access to the function that way we store the result inside of an array we have just been learning about this refactoring
        // now because we have access to that state we can see what it returns
        //we don't want to have r
        // we can remove this  and add a function
        
       
        // here we are stubbing the value when we should observing the value
        // but we want to remove the stub
        
        
        
        // the system under test
        // remember we are seeing how the controller is interacting so we need to make sure we are comparing to see the state
        
        // when we we load
        // we want to test for  error, we should expect to get an error
        // we need to see  how all of these objects will begin to collaborate
        // remember this is a function and the in so its describing to us because its anonymous function that its has an argument
        
        sut.load { capturedErrors.append($0)}
        client.complete(index: 0, with: clientError)
    
        //expect an err
        
        XCTAssertEqual(capturedErrors, [.connectivity])
        
    }
        // now we want to check and see if we are getting data from the requested URL
    
    func test_load_requestDataFromURL() {
        // we can see theres a bunch of code repeating here
        // how about what we make a factory pattern
        // given
        let url: URL = URL(string: "https://amazon.com")!
        let requestedtURLs = [url]
        let (sut, client) = makeSUT(url: url)
        // when
        // we are using method injection here and each has there pros and cons
        sut.load()
        
        // assert
        
        XCTAssertEqual(client.requestMessages, requestedtURLs)
    }
    
    // we need to have clear seperation
    
    func test_load_requestDataTwiceFromURL() {
        // given
        
        let `url`: URL = URL(string: "https://amazon.com")!
        let(sut, client) = makeSUT()
        // when we execute the load method twice
        // expect to see a count that reflect the total number of times we we executed
        // we want to see how these objects are all collaborating with each other
        sut.load()
        sut.load()
        // but we can refactor this code, we want to test the accuracy, it only checks to see if the we have the last count
        
        XCTAssertEqual(client.requestMessages, [url, url])
    }
    
    // we can use a helper function because its a set of instructions to write more clean code and create more reusable code
    private func makeSUT(url: URL = URL(string: "https://amazon.com")!)->(RemoteFeedLoader, HTTPClientSpy) {
        // remember we are potraying the system
        // this is intialized in  memory
        // the system under test is the higher implementation
        let client: HTTPClientSpy = HTTPClientSpy()
        let sut: RemoteFeedLoader = RemoteFeedLoader(client: client, url: url)
        
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
    // we don't want to stub the behavior but we want to watch the behavior so simulating that behavior is helpful
    var error: Error?
    var errorCompletions =  [(Error)->Void]()
// every function should have a purpose
    // get responsibility is to get the response or error from the client
    
    func get(from url: URL, handler: @escaping (Error) -> Void) {
        // we are injecting with behavior
        // i guess technically there isn't the array inside of there and again make sure you see this function
        errorCompletions.append(handler)
        // this  logic does not need to be included
        requestMessages.append(url)
    }
    
    func complete(index: Int, with error: Error) {
        // we need to get access to the array
        // we can check to see how many times this was called
        
        // remember we need too access it will return us a pointer and then from there
        errorCompletions[index](error)
    }
    
    
    // we can create a function which purpose is to invoke a error and see how does the system handle this rather than stubbing the expected behavior
    // at right we were testing to see if the
    var requestMessages: [URL] = [URL]()
}



