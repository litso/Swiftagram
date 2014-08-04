//
//  Maybe.swift
//  Swiftagram
//
//  Created by Robert Manson on 8/3/14.
//
//  Taken from "Functional Programming in Swift"
//  http://www.objc.io/books/

import UIKit

operator infix >>= {}
@infix func >>= <U,T> (maybeX : T?, f : T -> U?) -> U? {
    if let x = maybeX
    {
        return f(x)
    }
    else
    {
        return nil
    }
}
