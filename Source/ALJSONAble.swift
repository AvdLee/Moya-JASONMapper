//
//  ALJSONAble.swift
//  Pods
//
//  Created by Antoine van der Lee on 26/01/16.
//
//

import Foundation
import JASON

public protocol ALJSONAble {
    init?(jsonData:JSON)
}