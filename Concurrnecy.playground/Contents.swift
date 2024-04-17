import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution=true
// Part 1-----

// Concurrency is executing multuiple task or event at the same time
/// We can achive currency through Time Slicing and Context Switching


// What is Dipatch(GCD)
///  Execute code concurrently on multicore hardware by submitting work to dispatch queues managed by the system.
///  GCD is the queue based API which allows to execute closures on workers pool in the FIFO order.
///  Suppose there are tasks we submit those task to Queue then GCD take care of our task in FIFO order

// Dispatch Queue:- It is the abstraction layer on top of the queue.
/// GCD manages a collection of dispatch queues. They are usually referred as queues. The work or tasks submitted these dispatch queus is executed on a pool of threds
///  An application submit task to dispatch queue in the form of locks of either synchronously or asynchrounously
// Synchronous :- Means Block the current execution on thread untill this task completed
// Asynchronous
/// - Means continue the current execution that was happening keep doing it while this task which i am about to submit can be executed asynchronously
/// Synhcronus and Asynchronous are the manner of exetion which say how the task are gonna executed
// Serial vs Concurrent
/// Serial means one task at a time
/// Concurrent multiple task at a time
///
// :- QoS(Quality of service)
/// It is an enumeration used to specify the priority level for tasks executed in a concurrent queue.

//var count=0
//DispatchQueue.main.async {  // main queue is serial Queu
//    for i in 0...3{
//        count=i
//        print(count)
//    }
//}
//for i in 4...6{
//    count=i
//    print(count)
//}
//
//DispatchQueue.main.async {
//        count=9
//        print(count)
//}

//Output would be 4,5,6,0,1,2,3,9
/// Program start from line 29 we submit our task to main queue which is a serial queue in asynchronous manner meaning only one task at a time without blocking current execution, then
/// the normal loop executed normally giving the output 4,5,6 then another task submiited to main queue so total task in queue is 2, queue is a fifo order our first task dispatch first whcih
/// print 0,1,2,3 then second task dispatch whcih is 9

//------------------------------------------------------Part2-------------------------------------------------------------------//

// GCD handled the Dispatch Queue
/// thre are three types of Dispatch Queues
/// 1:- main queue
/// 2:- global queue
/// 3:- custom queue

// Main Queue:- It is system created, serial queue and uses the main thread
///



/// weak and unowned
/// :- Weak Keyword
/// use a weak  reference when the other instance have shorter life time- that is when the other instance can be deallocated first.
///   or simple terms in order to use weak when we find that in our object relationship there is probability that one of the object can be nil
///  let take the below example a Person either have Bank account or not so it better to use weak while assigning a BankAccount object in Person Class
///  we shouldnt use let with weak because in future person can open a Bank Account so we can assign a Bank account to user.
///   we should declare weak property as Optional
// :- Unowned
/// Let take this below example of Persona and Bank Account
/// We should use unowned when a property deos not exist without other other property. A bank account cannot exist without a person so we should declare it should link with a person
/// so a person property in Bank Account class cannot be optional
//class Person{
//    var name:String
//    var bankAccount:BankAccount?
//    init(_name: String) {
//        name = _name
//        print("person initialized")
//    }
//    
////    func printName(){
////        print("name is ", name)
////    }
//    deinit{
//        print("person deinitilezed")
//    }
//}
//
//class BankAccount{
//    var accNumber:Int
//    unowned var person:Person
//    init(_accNumber: Int, _person: Person) {
//        accNumber = _accNumber
//        person = _person
//        print("Bank initialized")
//    }
//    deinit{
//        print("Bank deinitialized")
//    }
//}
//
//if (1==1){
//    var person:Person?=Person(_name: "kashif")
//    var bank:BankAccount?=BankAccount(_accNumber: 345, _person: person!)
//    person?.bankAccount=bank
////    bank?.person=person
////    person?.bankAccount=nil
////    person=nil
////    bank=nil
////    let obj=Person(name: "kashif")
////    obj.printName()
//}

//func closure(name:String, completion:@escaping (String, Int)->Void){
//    let age=20
//    print(name,"in func")
//    completion(name, age)
//    print("end of function")
//}
//
//closure(name: "kashif"){name, age in
//        print(name, age , "in closure")
//}
//let q = DispatchQueue.global()
//
//let text = q.sync {
//    return "this will block"
//}
//print(text)
//
//q.async {
//    print("this will return instantly")
//}
//var q=DispatchQueue.global(qos: .userInitiated)
//var custom=DispatchQueue(label: "a")
//
//custom.as {
//    print(Thread.isMainThread ? "usign amin trhead" : "not using amin thread")
//}

// :- FAQ on Concurrency

// 1:- Predict the output
// 2:- What is QoS and where should you use which one?
/// Ans:- QoS test the system how should it utilize the resources, what resource which tread showuld be used, access to various streams like I/O, scheduling priority.
///  userInteractive:- Where UI update is inivolved highest priority
///  userInitiated:- Immediate result data required for seamless UI experience, e.g: you are scrolling a page and load a next data to show user
///   utility:- a long running task and user is aware of the progress
///   background:- not visible to user and user not aware of it.

// :- How can you make multiple API calls together and proceed only on the completion of all?

//:- Fix the code

//:- Difference between GCD and Operation Queue
/// Ans :- GCD is lower level API while Operation Queue build on top of that
///  OQ has higher level of abstraction

//:- Can we cancel the task in GCD?
/// ANs:- Using DispatchWorkItem you can cancel the task in GCD

//:- How can you make operation asynchronous




//------------------------------------------------------DSA Question-------------------------------------------------------------------//

// :- Find second minimum in an array in one pass


//let arr=[1,2,34,6,7,8,56]
//var first=Int.max
//var second=Int.max
//
//for i in arr{
//    if i<first{
//        second=first
//        first=i
//    } else if (i<second && i != first){
//        second=i
//    }
//}
//print(second)

// :- Find second maximum in an array in one pass

//let arr=[1,2,34,6,7,8,56,52]
//var first=Int.min
//var second=Int.min
//
//for i in arr{
//    if i>first{
//        second=first
//        first=i
//    } else if (i>second && i != first){
//        second=i
//    }
//}
//print(second,first)


//let str="mohdkashifahmed"
//
//var dict=[Character:Int]()
//for i in 
//var repeatt=""
//for i in str{
//    dict[i, default: .zero] += 1
//}
//
//for (k,v) in dict{
//    if v>1{
//        repeatt += String(k)
//    }
//}
//print(repeatt)

//@propertyWrapper
//
//struct Clamped<Value:Comparable>{
//    var value:Value
//    let range:ClosedRange<Value>
//    
//    init(wrappedValue: Value, range: ClosedRange<Value>) {
//        self.value = value
//        self.range = range
//    }
//}


//struct Kitten {
//    
//}
//func showKitten(kitten: Kitten?) {
//    
//    guard let k = kitten else { return
//        
//        print("There is no kitten")
//        
//    }
//    print(k,"empty")
//}



var thing = "cars"

let closure = {
print("I love \(thing)")

}

thing = "airplanes"
closure()

func countUniques<T: Comparable>(_ array: Array<T>) -> Int {
    let sorted = array.sorted()
    print(sorted)
    let initial: (T?, Int) = (.none, 0) //
    print(type(of: initial))
    let reduced = sorted.reduce(initial) {
        ($1, $0.0 == $1 ? $0.1 : $0.1 + 1)
    }
    return reduced.1
}
//
print(countUniques([2,3,4,5,6,6,3,5.6]))
//
//extension Array where Element:Comparable{
//    func countUniques() -> Int {
//        let sorted = self.sorted()
//        let initial: (Element?, Int) = (.none, 0) //
//        let reduced = sorted.reduce(initial) {
//            ($1, $0.0 == $1 ? $0.1 : $0.1 + 1)
//        }
//        return reduced.1
//    }
//}
//[2,3,4,5,6,6,3,5.6].countUniques()

//func getName(){
//    var name:String
//    var closure:(()->())={}
//    print("hello")
//    closure()
//    closure={
//        print("world")
//    }
//}
//getName()

class SomeClass{
    var member:String?
    func setMember(member:String){
        self.member=member
    }
}
var someClass:SomeClass?
print(someClass,"someclass")
if someClass?.setMember(member: "swift") != nil{
    print("attached")
} else {
    print("not attached")
}
//Imagine you are tasked with optimizing the inventory management system for a popular e-commerce platform. The platform tracks the stock of various products using a data structure of your choice (array, string, queue, or linked list). Your challenge is to implement an efficient algorithm that processes incoming orders and updates the stock accordingly. The algorithm should handle two types of orders: 'buy' orders that decrease the stock and 'restock' orders that increase the stock. The input will be a list of orders, where each order is represented as a string in the format 'type:product_id:quantity'. The output should be the final stock of each product after processing all the orders

//Input:['buy:1:5', 'restock:2:10', 'buy:1:10', 'restock:1:20', 'buy:2:5']

//Output:{'1': 15, '2': 5}

//Explanation:Initially, the stock is empty. The first 'buy' order decreases the stock of product '1' by 5, resulting in a negative stock (-5) which is invalid. The next 'restock' order increases the stock of product '2' by 10. The second 'buy' order for product '1' is ignored since the stock is already negative. The following 'restock' order increases the stock of product '1' by 20, making it 15. Finally, the last 'buy' order decreases the stock of product '2' by 5, resulting in a final stock of 5 for product '2'.
