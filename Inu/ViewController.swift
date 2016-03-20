//
//  ViewController.swift
//  Once
//
//  Created by kingkong999yhirose on 2016/03/18.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OnceType {
    
    var number: Int = 0
    func increment() -> Int {
        number = number + 1
        return number
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        once.call() {
            print("\(increment()): Calling")
        }
        once.call() {
            fatalError("Not call")
        }
        let number: Int = 1
        once.call(number) {
            print("\(increment()): Calling")
        }
        once.call(number) {
            fatalError("Not call")
        }
        once.call(self) {
            print("\(increment()): Calling")
        }
        once.call(self) {
            fatalError("Not call")
        }
        once.call("key") {
            print("\(increment()): Calling")
        }
        once.call("key") {
            fatalError("Not call")
        }
        
        once.clearAll()
        once.call() {
            print("\(increment()): Calling")
        }
        once.call() {
            fatalError("Not call")
        }
        
        once.call(self) {
            print("\(increment()): Calling")
        }
        once.call(self) {
            fatalError("Not call")
        }
        once.call(self) {
            print("\(increment()): Calling")
        }
        once.call(self) {
            fatalError("Not call")
        }
        once.call("key") {
            print("\(increment()): Calling")
        }
        once.call("key") {
            fatalError("Not call")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        once.call("key") {
            fatalError("Not call")
        }
        once.call() {
            print("\(increment()): Calling")
        }
        once.call() {
            fatalError("Not call")
        }
        
        printWithIterator()
        printWithIterator()
        printOnce()
    }
    
    private func printOnce() {
        for _ in 1...10 {
            once.call() {
                print("Print once")
            }
        }
    }
    
    private func printWithIterator() {
        for i in 1...10 {
            once.call(self, andKey: "\(i)") {
                print("Print iterator: \(i)")
            }
        }
    }
}

