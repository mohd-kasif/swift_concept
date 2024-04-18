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

//----------------------------------------------------Topic:-Initialization--------------------------------------------------------//

// It is the process of preparing of instance of class, struct and enum for use.
/// Unlike objective-C initializzers swift initilizers dont return values.
/// Their primary role is to ensure that new instances of a type are correctly initialized before they’re used for the first time.

///Classes and structures must set all of their stored properties to an appropriate initial value by
///the time an instance of that class or structure is created. Stored properties can’t be left in an indeterminate state

/// We can set stored property of type within initializer or providing a default value.
///
/// initializer are called to create new instance of particular type. It is like a instance method with no parameter.
///  Ex:- init(){   perform some initiliazton here}

struct Celcius{
    var temperature:Double
    init(fromFahrenheit fahrenhrit:Double) {
        self.temperature=(fahrenhrit-32)/1.8
    }
    init(fromKelvin kelvin:Double) {
        self.temperature=kelvin-273.15
    }
}

let fahrenheit=Celcius(fromKelvin: 73.15)
let kelvin=Celcius(fromFahrenheit: 212.65)

/// Properie sof optional type are automatically initialized with a value of nil, indicating that the property is deliberately intended to have “no value yet” during initialization
class SurveyQuestion{
    var text:String?
    var response:String?
    init(text: String) {
        self.text = text
    }
    
    func ask(){
        print(text as Any,"text in ask function")
    }
}

let question=SurveyQuestion(text: "how are you")
print(question.response as Any)
question.response="i am fine"

//Memberwise Initializers for Structure Types

///Unlike a default initializer, the structure receives a memberwise initializer even if it has stored properties that don’t have default values.

struct Size{
    var width=4.5
    var length=3.2
}

var obj=Size(width: 2, length: 2)
/// Size struct provide you memeberwise initializer when you create instance of Size it gives you memeberwise initializer
///  Also we can omit any property that have default values
var omitProperty=Size(length:23)  // omit width property

// Initializers Delegation
/// Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers
/// The rules for ini Initializers Delgation are different for value type and reference type for struct and enum it is simple because they dont support inheritance we can call other init method of same struct and enum with self.init()

//------------------------------------------------Class Inheritance and Initialization--------------------------------------------//
// Swift defines two kinds of initializers for class types to help ensure all stored properties receive an initial value.
//  These are known as designated initializers and convenience initializers


///Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain

///Convenience initializers are secondary, supporting initializers for a class.You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.

class Vehicel{
    var numberOfWheels=2
    var description:String{
        return "\(numberOfWheels) wheels"
    }
}
let vehicel=Vehicel() // Vwhcile provide deafult initilizer for sored property
//The default initializer (when available) is always a designated initializer for a class

//print(vehicel.description)


class Car:Vehicel{
    override init() { /// the bicyle provide a custom designated initializer, init(). This designated matheces the designated initalizer from the supercalss of Car which is Vehicle,
        super.init()  /// so the init of this class marked with override modifier, it start calling the designated init of superclass(Vehicle),
        numberOfWheels=4 ///This ensures that the numberOfWheels inherited property is initialized by Vehicle before Car has the opportunity to modify the property
        /// After calling super.init(), the original value of numberOfWheels is replaced with a new value of 2.
    }
}

var car=Car()
print(car.description)


//------------------------------------Designated and Convenience Initializers in Actionin-------------------------------//

/// Food class of one property name and two initializers
class Food{
    var name:String
    /// this initializer is used to create new Food instance with speicific name
    init(name: String) { /// class dont have memberwise initializer  so the Food provide a desognated initializer that take a single argument.
        self.name = name
    }
    convenience init(){
        self.init(name: "Unnamed")
    }
}

//let food=Food()
//let food1=Food(name: "Mutton")
//print(food.name)


class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}



//------------------------------------------------------Topic :-  Optional Chaining-------------------------------------------------//


//Optional chaining is a process for querying and calling properties,
//methods, and subscripts on an optional that might currently be nil.
//If the optional contains a value, the property, method, or subscript call succeeds; if the optional is nil, the property, method, or subscript call returns nil

// Example:-

// Here we define a class with one stored optional property member and a function whcih takes one parameter
class SomeClass{
    var member:String?
    
    func setMemeber(member:String){
        self.member=member
    }
}

var someClass:SomeClass?  // here we define a instance, currently it has no value so it is nil

if someClass?.setMemeber(member: "kashif") != nil{ /// here we are accesing memebr of optional instance setMemebr someClass is nil so the method is accessing will not
    print("Attached")                                   /// succeed and it print "Not Attached"
} else {
    print("Not attached")
}


//------------------------------------------------------Topic :-  Error Handling------------------------------------------------------//

//Error handling is the process of responding to and recovering from error conditions in your program.
//Swift provides first-class support for throwing, catching, propagating, and manipulating recoverable errors at runtime.

// :- Representing and Throwing Errors
///In Swift, errors are represented by values of types that conform to the Error protocol.
///This empty protocol indicates that a type can be used for error handling.


enum APiError:Error{ /// enum is particularly well suited to modelling a group related error condition,
    case requestFailed(description:String, erroCode:String="")/// associated value for allowing info about nature of error to be communicated
    case invalidData
    case notFound(description:String)
}

//Throwing an error lets you indicate that something unexpected happened and the normal flow of execution can’t continue.


// Handling Errors:-

/// when error is occured, some surronding piece of code responsible for handling those error
///
struct Person{
    var name:String
    var age:Int
}

class FetchName{
    var person=["Kashif":Person(name: "kashif", age: 24),
                "Aquib":Person(name: "aquib", age: 23),
                "Akhlad":Person(name: "akhlad", age: 15)
    ]
    
    var personAge=90
    func findName(name:String) throws{
        guard let name=person[name] else {
            throw APiError.notFound(description: "Requested Data Not Found")
        }
    }
}

var fetchname=FetchName()
do{
    try fetchname.findName(name: "Kshif")
} catch {
    print(error,"Error")
}
