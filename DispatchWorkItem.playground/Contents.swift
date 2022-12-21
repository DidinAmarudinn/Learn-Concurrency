import UIKit

var value = 5

let workItem = DispatchWorkItem {
    value += 5
}


workItem.perform()


let queue = DispatchQueue(label: "com.didinamarudin.dispatchWorkItem", qos: .utility)
queue.async(execute: workItem)


workItem.notify(queue: DispatchQueue.main) {
    print("Final value: \(value)")
}
