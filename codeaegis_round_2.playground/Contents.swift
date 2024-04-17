import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution=true

// :- Question 1
class Tutorial {
    var difficulty: Int = 1
}

var tutorial1 = Tutorial()
var tutorial2 = tutorial1
tutorial2.difficulty = 2
print(tutorial1.difficulty)
print(tutorial2.difficulty)

/// would there is any difference if Tutorial was class
///

// :- Question 2
import UIKit
var view1 = UIView()
view1.alpha = 0.5
let view2 = UIView()

view2.alpha=0.5 // will this line compile
/// yes this line will compile even if we declare view2 as constant we are accessing properties of view2 which can we access as UIView() is a class component

// :- Question 3 is there any ways we can optimize sort closure
var animals = ["fish", "cat", "chicken", "dog"]
animals.sort { (one: String, two: String) -> Bool in return one < two
}
print(animals)

// :- Number of ways to unwrap an optional:-
let num:Int?=4
/// There are multiple ways to unwrap an optional
/// 1:- Force Unrap
print(num!)

/// 2:- Optional Binding
///  Use guard let or if let to unwrap an optional and bind it to new constant or variable
if let newNum=num{
    ///code to executed when num is not nil
} else {
    ///code to executed when num is nil
}

//guard let newNum=num else {
////    return
//}

/// 3:- Nil Coalescing Operator
///  Use to unwrap an optional if there is a vlaue return rthe value if the value is nil then use the default value instead
print(num ?? 0)

/// 4:- Optional Chaining(?.)
/// Use optional chaining when you want to access properties, methods, and subscripts of an optional that might be nil.
///  If any link in the chain is nil, the entire chain evaluates to nil
///  let result = optionalValue?.someProperty

/// 5:- Implicitly Unwrapped Optionals (!):
/// Implicitly unwrapped optionals are declared using ! instead of ?. They behave like normal optionals, but their values are automatically unwrapped when accessed, assuming they're not nil. However, accessing a nil value will trigger a runtime error.
let optionalValue: Int! = 42
let newValue = optionalValue // this is safe as long as optionalValue is not nil

// :-  Below are the two function make a generic function whcih can accept int and string
func areIntEqual(_ x: Int, _ y: Int) -> Bool {
    return x == y
}
func areStringsEqual(_ x: String, _ y: String) -> Bool {
    return x == y
}

func genericFunction<T:Comparable>(_ x:T, _ y:T)->Bool{
    return x==y
}

print(genericFunction("a","b"))
//print(genericFunction(2,5))

// :- Question
var thing = "cars"

let closure = { [thing] in
print("I love \(thing)")
}
thing = "airplanes"
closure() // what will be the output
///  I love cars
///   what if we remove [thing] array in it then the output will be "I love airplanes"

// :- Question
//func countUniques<T: Comparable>(_ array: Array<T>) -> Int {
//    let sorted = array.sorted()
//    let initial: (T?, Int) = (.none, 0) //
//    let reduced = sorted.reduce(initial) {
//        ($1, $0.0 == $1 ? $0.1 : $0.1 + 1)
//    }
//     return reduced.1
//}

print(countUniques([4,5,6,7,6,7]))
/// modified countUniques in such a way that it can be executed like this [4,5,6,7,6,7].countUniques()

//extension Array where Element:Comparable{
//    func countUniques()->Int{
//        let sorted=self.sorted()
//        let initial: (Element?, Int) = (.none, 0)
//        let reduced = sorted.reduce(initial){
//            ($1, $0.0 == $1 ? $0.1 : $0.1 + 1)
//        }
//        return reduced.1
//    }
//}



//let str="I Love Code"
//var ans=""
//for i in str{
//    ans = String(i) + ans
//}
//print(ans)

//func fetchImage() async throws -> [UIImage]{
//    return [UIImage]
//}
//func imageFetch(completion: (Result<[UIImage], Error>)-> Void){
//    
//}
//
//enum MyError<Success, Failure> where Failure:Error{
//    case success(Success)
//    
//    case failure(Failure)
//}
//UIView

var name:String?="Kashif"
