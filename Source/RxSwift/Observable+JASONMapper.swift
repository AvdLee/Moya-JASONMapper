//
//  Observable+JASONMapper.swift
//
//  Created by Antoine van der Lee on 26/01/16.
//  Copyright © 2016 Antoine van der Lee. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import JASON

/// Extension for processing Responses into Mappable objects through ObjectMapper
public extension ObservableType where E == Response {

    /// Maps data received from the signal into an object which implements the ALJSONAble protocol.
    /// If the conversion fails, the signal errors.
    public func mapObject<T: ALJSONAble>(to type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.map(to: T.self))
        }
    }

    /// Maps data received from the signal into an array of objects which implement the ALJSONAble protocol.
    /// If the conversion fails, the signal errors.
    public func mapArray<T: ALJSONAble>(to type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.map(to: [T.self]))
        }
    }
}
