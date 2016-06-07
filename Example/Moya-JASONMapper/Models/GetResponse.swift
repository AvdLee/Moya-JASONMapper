//
//  GetResponse.swift
//  Moya-JASONMapper
//
//  Created by Antoine van der Lee on 26/01/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Moya_JASONMapper
import JASON

final class GetResponse : ALJSONAble {
    
    let url:NSURL?
    let origin:String
    let args:[String: String]?
    
    required init?(jsonData:JSON){
        self.url = jsonData["url"].nsURL
        self.origin = jsonData["origin"].stringValue
        self.args = jsonData["args"].object as? [String : String]
    }
    
}

extension GetResponse : CustomStringConvertible {
    var description: String {
        return "[GetResponse] Stubbed ip response is:" + self.origin
    }
}