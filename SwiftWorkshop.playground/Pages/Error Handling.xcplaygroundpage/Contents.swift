import Foundation

//throws func
enum FuncError : Error {
    case TooBig
}

func errorWhenOverTen(_ value:Int) throws {
    if value < 10 {
        print("everything is ok")
    }
    else {
        throw FuncError.TooBig
    }
}

do {
    try errorWhenOverTen(101)
} catch FuncError.TooBig {
    print("Error catched : \(FuncError.TooBig)")
}

let age = -3
//assert(age >= 0, "age can't not be under 0")

// -Ounchecked 을 끄면 precondition 은 컴파일러에서 체크하지 않게 됨.
//precondition(age >= 0, "age must be over 0")

//Rethrowing Functions and Methods

//A function or method can be declared with the rethrows keyword to indicate that it throws an error only if one of it’s function parameters throws an error. These functions and methods are known as rethrowing functions and rethrowing methods. Rethrowing functions and methods must have at least one throwing function parameter.
