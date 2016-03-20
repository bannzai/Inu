//
//  Once.swift
//  Once
//
//  Created by kingkong999yhirose on 2016/03/18.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import UIKit

public class Once {
    private var callStack: [String] = []
    private let uuid = NSUUID().UUIDString
    
    private init() { }
    
    // MARK: - Call
    public func call(withKey: String = __FUNCTION__, @noescape _ closure: Void -> Void) {
        if callStack.contains(withKey) {
            return
        }
        closure()
        callStack.append(withKey)
    }
    
    // MARK: Clear
    public func clearAll() -> [String] {
        let beforeRemoveStack = callStack
        callStack.removeAll()
        return beforeRemoveStack
    }
    
    public func clear(withKey key: String) -> [String] {
        return clear() { $0 == key }
    }
    
    public func clear(@noescape withCondition condition: String -> Bool) -> [String] {
        let beforeFilterStack = callStack
        callStack = callStack.filter { !condition($0) }
        return beforeFilterStack
    }
}


private struct OnceAssociatedObjectHandle {
    static var OnceKey: UInt8 = 0
}

public protocol OnceType: AnyObject { }
public extension OnceType {
    public var once: Once {
        guard let object = objc_getAssociatedObject(self, &OnceAssociatedObjectHandle.OnceKey) as? Once else {
            let once = Once()
            objc_setAssociatedObject(self, &OnceAssociatedObjectHandle.OnceKey, once, .OBJC_ASSOCIATION_RETAIN)
            return once
        }
        return object
    }
}
