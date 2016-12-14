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
        let expectation = self.expectation(description: "This call call a Get API call and returns a GetResponse.")
        
        var getResponseObject:GetResponse?
        var errorValue:Moya.Error?
        
        let cancellableRequest:Cancellable = stubbedProvider.request(ExampleAPI.getObject) { (result) -> () in
            switch result {
            case let .success(response):
                do {
                    getResponseObject = try response.map(to: GetResponse.self)
                    expectation.fulfill()
                } catch {
                    expectation.fulfill()
                }
            case let .failure(error):
                errorValue = error
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseObject, "We should have a parsed getResponseObject")
            
            cancellableRequest.cancel()
        }
    }
    
    func testReactiveCocoaMappingObject(){
        let expectation = self.expectation(description: "This call call a Get API call and returns a GetResponse through a ReactiveCocoa signal.")
        
        var getResponseObject:GetResponse?
        var errorValue:Moya.Error?
        
        let disposable = RCStubbedProvider.request(ExampleAPI.getObject).map(to: GetResponse.self)
            .on(failed: { (error) -> () in
                errorValue = error
            },
                completed: { () -> () in
                    expectation.fulfill()
            },
                value: { (response) -> () in
                    getResponseObject = response
            }
            ).start()
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseObject, "We should have a parsed getResponseObject")
            
            disposable.dispose()
        }
    }
    
    func testRxSwiftMappingObject(){
        let expectation = self.expectation(description: "This call call a Get API call and returns a GetResponse through a ReactiveCocoa signal.")
        
        var getResponseObject:GetResponse?
        var errorValue:Moya.Error?
        
        let disposable = RXStubbedProvider.request(ExampleAPI.getObject).map(to: GetResponse.self).subscribe(onNext: { (response) -> Void in
            getResponseObject = response
            }, onError: { (error) -> Void in
                errorValue = error as? Moya.Error
                expectation.fulfill()
            }, onCompleted: { () -> Void in
                expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseObject, "We should have a parsed getResponseObject")
            
            disposable.dispose()
        }
    }
    
    func testCoreMappingArray(){
        let expectation = self.expectation(description: "This call call a Get API call and returns a GetResponse.")
        
        var getResponseArray:[GetResponse]?
        var errorValue:Moya.Error?
        
        let cancellableRequest:Cancellable = stubbedProvider.request(ExampleAPI.getArray) { (result) -> () in
            switch result {
            case let .success(response):
                do {
                    getResponseArray = try response.map(to: [GetResponse.self])
                    expectation.fulfill()
                } catch {
                    expectation.fulfill()
                }
            case let .failure(error):
                errorValue = error
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseArray, "We should have a parsed getResponseObject")
            
            cancellableRequest.cancel()
        }
    }
    
    func testReactiveCocoaMappingArray(){
        let expectation = self.expectation(description: "This call call a Get API call and returns a GetResponse through a ReactiveCocoa signal.")
        
        var getResponseArray:[GetResponse]?
        var errorValue:Moya.Error?
        
        let disposable = RCStubbedProvider.request(ExampleAPI.getArray).map(to: [GetResponse.self])
            .on(failed: { (error) -> () in
                errorValue = error
            },
                completed: { () -> () in
                    expectation.fulfill()
            },
                value: { (response) -> () in
                    getResponseArray = response
            }).start()
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseArray, "We should have a parsed getResponseObject")
            
            disposable.dispose()
        }
    }
    
    func testRxSwiftMappingArray(){
        let expectation = self.expectation(description: "This call call a Get API call and returns a GetResponse through a ReactiveCocoa signal.")
        
        var getResponseArray:[GetResponse]?
        var errorValue:Moya.Error?
        
        let disposable = RXStubbedProvider.request(ExampleAPI.getArray).map(to: [GetResponse.self]).subscribe(onNext: { (response) -> Void in
            getResponseArray = response
            }, onError: { (error) -> Void in
                errorValue = error as? Moya.Error
                expectation.fulfill()
            }, onCompleted: { () -> Void in
                expectation.fulfill()
        })
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(errorValue, "We have an unexpected error value")
            XCTAssertNotNil(getResponseArray, "We should have a parsed getResponseObject")
            
            disposable.dispose()
        }
    }    
}
