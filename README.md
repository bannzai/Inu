# Inu
Easily way to write a control logic for call once function in instance.

# Usage
To support call once, a class needs to implement the OnceType

```swift
class ViewController: UIViewController, OnceType { 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
```

You can use ```once``` property. And ```once``` using ```call()``` method.
```call()``` is called only sometimes in same function.

```swift
func anyFunction() {
  once.call() {
      print("This statement is call once while self live")
  }
  once.call() {
      fatalError("Not call this statemenet")
  }
}
```

If want to call once again. You should call '''clearAll()``` method.
```clearAll()``` is clear all cache.  You can same ```call()``` one more time.
```
func callOneMoreTime() {
    once.clearAll()
    anyFunction() // <-  This statement is call once while self live
}
```

It's also possible to control ```call()```  with string key.
And you can use ```clear(withKey: String)``` method.

```
func callingWithKey() {
    once.call("key") {
        print("Calling")
    }
    once.call("key") {
        fatalError("Not Call")
    }
    once.call() {
        print("Calling")
    }
    once.clear(withKey: "key")
    once.call("key") {
        print("Calling")
    }
    once.call() {
        fatalError("Not Call")
    }
}
```


# License
Inu is released under the MIT license. See LICENSE.txt for details.





