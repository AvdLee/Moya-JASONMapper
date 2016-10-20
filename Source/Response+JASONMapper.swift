//
//  Response+JASONMapper.swift
//
//  Created by Antoine van der Lee on 26/01/16.
//  Copyright © 2016 Antoine van der Lee. All rights reserved.
//

import Foundation
import Moya
import JASON

public extension Response {

    /// Maps data received from the signal into an object which implements the ALJSONAble protocol.
    /// If the conversion fails, the signal errors.
    public func map<T: ALJSONAble>(to type:T.Type) throws -> T {
        let jsonObject = try mapJSON()
        
        guard let mappedObject = T(jsonData: JSON(jsonObject)) else {
            throw Error.jsonMapping(self)
        }
        
        return mappedObject
    }

    /// Maps data received from the signal into an array of objects which implement the ALJSONAble protocol
    /// If the conversion fails, the signal errors.
    public func map<T: ALJSONAble>(to type:[T.Type]) throws -> [T] {
        let jsonObject = try mapJSON()
        
        let mappedArray = JSON(jsonObject)
        let mappedObjectsArray = mappedArray.jsonArrayValue.flatMap { T(jsonData: $0) }
        
        return mappedObjectsArray
    }

}
