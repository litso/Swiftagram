//
//  Wrapper.swift
//  Swiftagram
//
//  Created by Robert Manson on 8/2/14.
//  Copyright (c) 2014 Robert Manson. All rights reserved.
//
//  "Best Wrapper Alive" - Jay-Z

import UIKit

class ArrayWrap {
    let originalArray: [AnyObject]
    init(array: [AnyObject]) {
        self.originalArray = array
    }
    func dictionary(index: Int) -> DictionaryWrap? {
        let obj: AnyObject? = originalArray[index]
        if let nextDictionary = obj as? [String: AnyObject] {
            return DictionaryWrap(dict: nextDictionary)
        }
        else {
            return nil
        }
    }
}
class DictionaryWrap {
    let originalDictionary: [String: AnyObject]
    init(dict: [String: AnyObject]) {
        self.originalDictionary = dict
    }
    func dictionary(key: String) -> DictionaryWrap? {
        let obj: AnyObject? = originalDictionary[key]
        if let nextDictionary = obj as? [String: AnyObject] {
            return DictionaryWrap(dict: nextDictionary)
        }
        else {
            return nil
        }
    }
    func array(key: String) -> ArrayWrap? {
        let obj: AnyObject? = originalDictionary[key]
        if let nextArray = obj as? [AnyObject] {
            return ArrayWrap(array: nextArray)
        }
        else {
            return nil
        }
    }
    func string(key: String) -> String? {
        let obj: AnyObject? = originalDictionary[key]
        if let stringValue = obj as? String {
            return stringValue
        }
        else {
            return nil
        }
    }
    func int(key: String) -> Int? {
        let obj: AnyObject? = originalDictionary[key]
        if let integerValue = obj as? Int {
            return integerValue
        }
        else {
            return nil
        }

    }
}
