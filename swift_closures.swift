import Foundation




let my_closure : (String) -> () = { name in

print("Happy birthday , \(name)");
}
my_closure("uzair")

// inline 

let inline_closure : (String) ->() = {
    print("Happy birthday \( $0)")
    }

inline_closure("iqbal")

// or we can create closure by 

let void_closure : (String) -> Void = { (name) -> Void in 

print("my name is \(name)")

}
void_closure("iqbal")


let string_closure : (String,String) -> String = { (f_name,l_name) -> String in 

return f_name + l_name

}



print(string_closure("uzair"," iqbal"))

// Trailing Closures

// If you need to pass a closure expression to a function as the function’s last argument and 
//closure expression is too long, it can be written as trailing closure. A trailing closure is written after the function call’s parentheses (), 
//even though it is still an argument to the function.

func makeSquareOf(number : Int , onCompletion : (Int) -> Void){

         let sqauare = number * number 
        onCompletion(sqauare)
        
        

}

// or we can also define function by this

// func makeSquare1(number:Int )->(Int)->Void{ 

//     let sqauare = number * number 
    


// }

makeSquareOf(number : 5 , onCompletion : {digit in 

    print("the square is \(digit)")

}) 

// or if closure is a last varialbe swift allow to write below code

makeSquareOf(number : 4){ digit in

print("the square is \(digit)")

}

// makeSquareOf1(number : 4){ digit in

// print("the square1 is \(digit)")

// }


// Capturing Values
// A closure can capture constants and variables from the surrounding context in which it is defined. 
//The closure can then refer to and 
//modify the values of those constants and variables from within its body
// This makeIncrementer function accepts one argument i.e. Int as input and returns a function type i.e. () -> Int. This means that it returns a function, rather than a simple value. 
//The function it returns has no parameters, and returns an Int value each time it is called.

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}


let incrementByTen = makeIncrementer(forIncrement: 10)
print(incrementByTen()) // returns a value of 10
print(incrementByTen()) // returns  a value of 20
print(incrementByTen()) // returns  a value of 30

import Foundation

class CaptureList: NSObject {
    let digit = 5
    typealias onCompletionHandler = (Int) -> Void
    override init() {
        super.init()
        
        makeSquareOfValue { squareDigit in
            print("Square of \(digit) is \(squareDigit)")
        }
    }
    
    func makeSquareOfValue(onCompletion: (Int) -> Void) {
        let squareDigit = digit * digit
        onCompletion(squareDigit)
    }
}

CaptureList()

// Note: As an optimization, Swift may instead capture and store a copy of a value 
// if that value is not mutated by a closure, 
// and if the value is not mutated after the closure is created.

// To get rid of long closure expression in function argument you can use typealias. write above in class code

// non escaping closure
//In Swift 3 . When you are passing a closure as the function argument, 
//the closure gets execute with the function’s body and returns the compiler back. As the execution ends, 
//the passed closure goes out of scope and have no more existence in memory.
// Closure parameters are non-escaping by default, if you wanna escape the closure execution, you have to use @escaping with the closure parameters.
// Lifecycle of the non-escaping closure:
// 1. Pass the closure as a function argument, during the function call.
// 2. Do some work in function and then execute the closure.
// 3. Function returns.
// Due to better memory management and optimizations, Swift has changed all closures to be non-escaping by default. CaptureList.swift is an example of non-escaping closure.
// Note: @non-escaping annotation applies only to function types
// A closure is said to be no escaping when the closure is passed as an argument to the function, and is called before the function returns. The closure is not used outside of the function.


func testFunctionWithNoEscapingClosure(myClosure:() -> Void) {
    print("function called")
    myClosure()
    print("function called1")
    return
}
//function call
testFunctionWithNoEscapingClosure {
    print("closure called")
}



// Escaping Closures:
// A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. Marking a closure with @escaping means you have to refer to self explicitly within the closure.
// Lifecycle of the @escaping closure:
// 1. Pass the closure as function argument, during the function call.
// 2. Do some additional work in function.
// 3. Function execute the closure asynchronously or stored.
// 4. Function returns.

// A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the 
//function returns or the closure is used outside of the body of the function.

var closureArr:[()->()] = []
func testFunctionWithEscapingClosure(myClosure:@escaping () -> Void) {
    print("function called")
    closureArr.append(myClosure)
     
    myClosure()
    print("function called1")  
    return
}
testFunctionWithEscapingClosure {
     print("closure called")
}

// AutoClosure
// A closure which is marked with @autoclosure keyword is known as autoclosure. @autoclosure keyword creates an automatic closure around the expression by adding a {}. 
// Therefore, you can omit braces {} when passing closures to a function.

// without @autoclosure
func someSimpleFunction(someClosure:()->(), msg:String) {
    print(msg)
    someClosure()
}
someSimpleFunction(someClosure: ({
    
    print("Hello World! from closure")
}), msg:"Hello Swift Community!")

// convert it into @autoclosure

func someSimpleFunction1(someClosure: @autoclosure ()->(), msg:String) {
    print(msg)
    someClosure()
}
someSimpleFunction1(someClosure: (print("Hello World! from closure")), msg:"Hello Swift Community!")

