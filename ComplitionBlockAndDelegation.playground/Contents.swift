import Cocoa

//func exspensiveTask(data: String, completion: @escaping(String)-> Void) {
// let queue = DispatchQueue(label: "com.didinamarudin.completionblock")
//    queue.async {
//        print("Processing: \(data)")
//        sleep(2)
//        completion("Processing \(data) finished")
//    }
//}
//
//
//let mainQueue = DispatchQueue(label: "com.didinamarudin.main", qos: .userInteractive)
//
//mainQueue.async {
//    exspensiveTask(data: "Get user") { result in
//        print(result)
//
//    }
//    print("Main Queue Run")
//
//
//}
//


protocol TaskDelegate {
    func taskFinished(result: String)
}

struct Task {
    var delegate: TaskDelegate?
    
    func exspesiveTask(data: String) {
        let queue = DispatchQueue(label: "com.didinamarudin.delegation")
        
        
        queue.async {
            print("Processing \(data)")
            
            sleep(2) // Imitate exspensive task - delayed for 2 second
            self.delegate?.taskFinished(result: "Processing \(data) form delegation Finished")
        }
    }
}


struct Main: TaskDelegate {
   
    func run() {
        let mainQueue = DispatchQueue(label: "com.didinamarudin.delegationmain", qos: .userInteractive)
        
        mainQueue.async {
            var task = Task()
            task.delegate = self
            task.exspesiveTask(data: "Get user from delegation")
            print("Main queue in delegation run")

        }
    }
}

extension Main {
    func taskFinished(result: String) {
        print(result)
    }
    
}

let main = Main()
main.run()
