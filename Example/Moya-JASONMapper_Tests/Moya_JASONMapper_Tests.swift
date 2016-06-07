//
//  Moya_JASONMapper_Tests.swift
//  Moya-JASONMapper_Tests
//
//  Created by Antoine van der Lee on 07/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
import Moya_JASONMapper
import Moya

@testable import Moya_JASONMapper_Example

class Moya_JASONMapper_Tests: XCTestCase {
    
    func testCoreMappingObject(){
        let expectation = expectationWithDescription("This call call a Get API call and returns a GetResponse.")
        
        var getResponseObject:GetResponse?
        var errorValue:ErrorType?
        
        let cancellableRequest:Cancellable = stubbedProvider.request(ExampleAPI.GetObject) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    getResponseObject = try response.mapObject(GetResponse)
                    expectation.fulfill()
                } catch {
                    expectation.fulfill()
                }
            case let .Failure(error):
                errorValue = error
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseObject, "We should have a parsed getResponseObject")
            
            cancellableRequest.cancel()
        }
    }
    
    func testReactiveCocoaMappingObject(){
        let expectation = expectationWithDescription("This call call a Get API call and returns a GetResponse through a ReactiveCocoa signal.")
        
        var getResponseObject:GetResponse?
        var errorValue:ErrorType?
        
        let disposable = RCStubbedProvider.request(ExampleAPI.GetObject).mapObject(GetResponse)
            .on(failed: { (error) -> () in
                errorValue = error
                }, completed: { () -> () in
                    expectation.fulfill()
            }) { (response) -> () in
                getResponseObject = response
            }.start()
        
        waitForExpectationsWithTimeout(10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseObject, "We should have a parsed getResponseObject")
            
            disposable.dispose()
        }
    }
    
    func testRxSwiftMappingObject(){
        let expectation = expectationWithDescription("This call call a Get API call and returns a GetResponse through a ReactiveCocoa signal.")
        
        var getResponseObject:GetResponse?
        var errorValue:ErrorType?
        
        let disposable = RXStubbedProvider.request(ExampleAPI.GetObject).mapObject(GetResponse).subscribe(onNext: { (response) -> Void in
            getResponseObject = response
            }, onError: { (error) -> Void in
                errorValue = error
                expectation.fulfill()
            }, onCompleted: { () -> Void in
                expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseObject, "We should have a parsed getResponseObject")
            
            disposable.dispose()
        }
    }
    
    func testCoreMappingArray(){
        let expectation = expectationWithDescription("This call call a Get API call and returns a GetResponse.")
        
        var getResponseArray:[GetResponse]?
        var errorValue:ErrorType?
        
        let cancellableRequest:Cancellable = stubbedProvider.request(ExampleAPI.GetArray) { (result) -> () in
            switch result {
            case let .Success(response):
                do {
                    getResponseArray = try response.mapArray(GetResponse)
                    expectation.fulfill()
                } catch {
                    expectation.fulfill()
                }
            case let .Failure(error):
                errorValue = error
                expectation.fulfill()
            }
        }
        
        waitForExpectationsWithTimeout(10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseArray, "We should have a parsed getResponseObject")
            
            cancellableRequest.cancel()
        }
    }
    
    func testReactiveCocoaMappingArray(){
        let expectation = expectationWithDescription("This call call a Get API call and returns a GetResponse through a ReactiveCocoa signal.")
        
        var getResponseArray:[GetResponse]?
        var errorValue:ErrorType?
        
        let disposable = RCStubbedProvider.request(ExampleAPI.GetArray).mapArray(GetResponse)
            .on(failed: { (error) -> () in
                errorValue = error
                }, completed: { () -> () in
                    expectation.fulfill()
            }) { (response) -> () in
                getResponseArray = response
            }.start()
        
        waitForExpectationsWithTimeout(10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseArray, "We should have a parsed getResponseObject")
            
            disposable.dispose()
        }
    }
    
    func testRxSwiftMappingArray(){
        let expectation = expectationWithDescription("This call call a Get API call and returns a GetResponse through a ReactiveCocoa signal.")
        
        var getResponseArray:[GetResponse]?
        var errorValue:ErrorType?
        
        let disposable = RXStubbedProvider.request(ExampleAPI.GetArray).mapArray(GetResponse).subscribe(onNext: { (response) -> Void in
            getResponseArray = response
            }, onError: { (error) -> Void in
                errorValue = error
                expectation.fulfill()
            }, onCompleted: { () -> Void in
                expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseArray, "We should have a parsed getResponseObject")
            
            disposable.dispose()
        }
    }    
}
