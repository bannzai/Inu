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
    
    // MARK: - Publish key
    private func publishKey(any: AnyObject, key: String) -> String {
        return key + ": " + publishKey(any)
    }
    
    private func publishKey(any: AnyObject) -> String {
        return "uuid: " + uuid + " any: " + String(any) + " :end "
    }
    
    // MARK: - Call
    public func call(any: AnyObject, andKey key: String = __FUNCTION__, @noescape _ closure: Void -> Void) {
        call(publishKey(any, key: key), closure)
    }
    
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
    
    public func clear(any: AnyObject, andKey key: String) -> [String]? {
        return clear(withKey: publishKey(any, key: key))
    }
    
    public func clear(with any: AnyObject) -> [String]? {
        return clear { $0.containsString(publishKey(any)) }
    }
    
    public func clear(withKey key: String) -> [String] {
        return clear() { $0 == key }
    }
    
    public func clear(@noescape withCondition condition: String -> Bool) -> [String] {
        let beforeFilterStack = callStack
        callStack = callStack.filter { !condition($0) }
        return beforeFilterStack
    }
    
    // MARK: Add
    public func addStack(keys: [String]?) {
        guard let keys = keys else {
            return
        }
        callStack.appendContentsOf(keys)
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
