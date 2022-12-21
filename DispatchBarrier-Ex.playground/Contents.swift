import UIKit
import Cocoa
class ThreadSafeArray {
    let issolation = DispatchQueue(label: "com.dicoding.dispatchbarrier", attributes: .concurrent)
    
    private var _array: [Int] = []
    
    var array: [Int] {
        get {
            return issolation.sync {
                _array
            }
        }
        
        set {
            issolation.async(flags: .barrier) {
                self._array = newValue
            }
        }
    }
    
}


