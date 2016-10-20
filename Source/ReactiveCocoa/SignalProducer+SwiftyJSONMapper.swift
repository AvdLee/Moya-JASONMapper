//
//  SignalProducer+JASONMapper.swift
//
//  Created by Antoine van der Lee on 26/01/16.
//  Copyright © 2016 Antoine van der Lee. All rights reserved.
//

import ReactiveSwift
import Moya
import JASON

/// Extension for processing Responses into Mappable objects through ObjectMapper
extension SignalProducerProtocol where Value == Moya.Response, Error == Moya.Error {

    /// Maps data received from the signal into an object which implements the ALJSONAble protocol.
    /// If the conversion fails, the signal errors.
    public func mapObject<T: ALJSONAble>(to type: T.Type) -> SignalProducer<T, Moya.Error> {
        return producer.flatMap(.latest) { response -> SignalProducer<T, Error> in
            return unwrapThrowable { try response.map(to: T.self) }
        }
    }

    /// Maps data received from the signal into an array of objects which implement the ALJSONAble protocol.
    /// If the conversion fails, the signal errors.
    public func mapArray<T: ALJSONAble>(to type: T.Type) -> SignalProducer<[T], Moya.Error> {
        return producer.flatMap(.latest) { response -> SignalProducer<[T], Error> in
            return unwrapThrowable { try response.map(to: [T.self]) }
        }
    }
}

/// Maps throwable to SignalProducer
private func unwrapThrowable<T>(_ throwable: () throws -> T) -> SignalProducer<T, Moya.Error> {
    do {
        return SignalProducer(value: try throwable())
    } catch {
        return SignalProducer(error: error as! Moya.Error)
    }
}
