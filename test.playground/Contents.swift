import Foundation
import Combine

//let arr=[1,2,3,4,5]
//print(arr)
//for i in arr{
//    print(i)
//}

//func makeGeneric<T:Numeric>(num:[T]){
////    print(type(of: num))
////    print(num)
//    for i in num{
//        print(type(of: i))
//    }
//}
//
//makeGeneric(num: [1,2,3,5.6])

//actor Counter{
//    var count:Int=0
//    let co=1
//    
//    func increment(){
//        count += 1
//    }
//
//}
//
//
//extension Counter{
//    nonisolated func countt(){
//        print(co)
//    }
//}
//
//let obj=Counter()
////await obj.increment()
//obj.countt()
//// Actors explained
///// They will s


// Delegate Pattern
/// Handing out some responsibilities to other class or entitty
class Counter{
    private var count:Int=0{
        didSet {
            print(count, "count value")
        }
    }
    
    
    func increment(){
        count += 1
    }
}


// Here Control depends on Counter
class Control{
    var delegate:Counter  /// creating a reference of Control Class
    init(delegate: Counter) {
        self.delegate = delegate
    }
    
    func buttonClicked(){
        self.delegate.increment()
    }
}

let counter=Counter()
let control=Control(delegate: counter)
control.buttonClicked()
control.buttonClicked()


// Delegate Pattern using protocol
/// Handing out some responsibilities to other class or entitty
protocol CounterDelegate{
    func increment()->Void
}
/// here we refactor Control which is no longer depend on Counter but any entity which conform to CounterDelegate protocol
class ControlClass{
    private var delegate:CounterDelegate
    init(delegate: CounterDelegate) {
        self.delegate = delegate
    }
    
    func buttonClicked(){
        self.delegate.increment()
    }
}
/// Now, any entity that implements the CounterDelegate protocol can be used as a delegate by ControlClass
// Counter class conform to CounterDelegate protocol
class CounterClass:CounterDelegate{
    private var count:Int=0{
        didSet{ print(count, "value")}
    }
    func increment() {
        self.count += 1
    }
}

let counterObj=CounterClass()
let controlObj=ControlClass(delegate: counterObj)
controlObj.buttonClicked()
controlObj.buttonClicked()


protocol Publisher<Output, Failure>{
    associatedtype Output
    associatedtype Failure:Error
    func receive<S>(Subscribe:S) where S: Subscriber
}


// Data inconsistency in updatePrice
class Product{
    var price:Double
    
    init(price: Double) {
        self.price = price
    }
    /// Problem here if two instance update the price at the same time it will lead to data inconsstency
    /// to solve this we can introduce the DispatchQueue
    func updatePrice(newPrice:Double){
        self.price=newPrice
    }
}

// Solution of above Data inconsistency when two instance update the update price at the same time

class MyProduct{
    private var price:Double
    private var priceQueue=DispatchQueue(label: "com.company.price") // serial dispatch queue
    init(price: Double) {
        self.price = price
    }
    
    //. this function safely retrieve the price synchronously
    func getPrice()->Double{
        var price:Double=0
        priceQueue.sync {
            price=price
        }
        return price
    }
    /// update the price in priceQueue asynchronously
    /// this function ensure the only one thread update the price at a time, if two thread want to update the price at same time first access queue only allow
    /// onlly inw thread to access it by acquiring a lock on a queue update the price and release the lock
    func updatePrice(newValue:Double){
        priceQueue.async {[weak self] in
            guard let self else {return}
            self.price=newValue
        }
    }
}

var array1=[1,3,4]
var array2=array1
// Copy in write
array1.withUnsafeBufferPointer{(p) in
print(p,"array 1 ")
}
array2.withUnsafeBufferPointer{(p) in
print(p,"array 2")
}

// Closure
/// Closures can capture and store references to any constants and variables from the context in which they are defined, known as closing over hence Closure.
/// Global functions: They have a name and can’t capture value.
/// Nested functions: They have a name and can capture values from their enclosing function.
/// Closure expressions: They don’t have name and can capture values from their surrounding context.
///
// Closure take no parameter and return nothing
let sayHello: () -> Void = {
    print("Hello")
}

sayHello() /// calling a closure
///
// Closure take one parameter and return 1 parameter
let helloWorld: (String) -> String={val in
    return val
}
print(helloWorld("kashif")) // calling a closure

//Capturing Values
///A closure can capture constants and variables from the surrounding context in which it is defined
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)

//incrementByTen() // returns a value of 10

//struct Product{
//    var price:Double=0{
//        didSet{
//            print(price,"prcie")
//        }
//    }
//    mutating func updatePrice(newPrice: inout Double){
//        self.price=newPrice
//    }
//}
//
//var obj=Product()
//var a=8.9
//obj.updatePrice(newPrice: &a)
//print(obj.price)







