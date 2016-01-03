//
//  Yaml+SwiftLint.swift
//  SwiftLint
//
//  Created by Scott Hoyt on 12/28/15.
//  Copyright © 2015 Realm. All rights reserved.
//

import Yaml

extension Yaml {
    var flatDictionary: [Swift.String : AnyObject]? {
        if let dict = dictionary {
            var newDict: [Swift.String : AnyObject] = [:]
            for (key, value) in dict {
                newDict[key.stringValue] = value.flatValue
            }
            return newDict
        } else if self.count == 0 || self == .Null {
            return [:]
        }

        print("Could not parse config dictionary")
        return nil
    }

    var flatArray: [AnyObject]? {
        if let arr = array {
            var newArr: [AnyObject] = []
            for value in arr {
                newArr.append(value.flatValue)
            }
            return newArr
        }

        print("Could not parse config array")
        return nil
    }

    var flatValue: AnyObject {
        switch self {
        case .Bool(let myBool):
            return myBool
        case .Int(let myInt):
            return myInt
        case .Double(let myDouble):
            return myDouble
        case .String(let myString):
            return myString
        case .Array:
            return self.flatArray! // This is valid because .Array will always flatten
        case .Dictionary:
            return self.flatDictionary! // This is valid because .Dictionary will always flatten
        case .Null:
            return NSNull()
        }
    }

    var stringValue: Swift.String {
        switch self {
        case .Bool(let myBool):
            return myBool.description
        case .Int(let myInt):
            return myInt.description
        case .Double(let myDouble):
            return myDouble.description
        case .String(let myString):
            return myString
        case .Array(let myArray):
            return myArray.description
        case .Dictionary(let myDictionary):
            return myDictionary.description
        case .Null:
            return "Null"
        }
    }
}
