//
//  ExampleAPI.swift
//  Moya-JASONMapper
//
//  Created by Antoine van der Lee on 25/01/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Moya
import Moya_JASONMapper
import ReactiveSwift
import JASON

let stubbedProvider = MoyaProvider<ExampleAPI>(stubClosure: MoyaProvider.immediatelyStub)

enum ExampleAPI {
    case getObject
    case getArray
}

extension ExampleAPI: JSONMappableTargetType {
    
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL { return URL(string: "https://httpbin.org")! }
    var path: String {
        switch self {
        case .getObject:
            return "/get"
        case .getArray:
            return "/getarray" // Does not really works, but will work for stubbed response
        }
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        return nil
    }
    var sampleData: Data {
        switch self {
        case .getObject:
            return stubbedResponseFromJSONFile("object_response")
        case .getArray:
            return stubbedResponseFromJSONFile("array_response")   
        }
    }
    var task: Task {
        return .requestPlain
    }
    var responseType: ALJSONAble.Type {
        switch self {
        case .getObject:
            return GetResponse.self
        case .getArray:
            return GetResponse.self
        }
    }
    var multipartBody: [Moya.MultipartFormData]? { return nil }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
}

protocol JSONMappableTargetType: TargetType {
    var responseType: ALJSONAble.Type { get }
}

private func stubbedResponseFromJSONFile(_ filename: String, inDirectory subpath: String = "", bundle:Bundle = Bundle.main ) -> Data {
    guard let path = bundle.path(forResource: filename, ofType: "json", inDirectory: subpath) else { return Data() }
    return (try? Data(contentsOf: URL(fileURLWithPath: path))) ?? Data()
}
