//: [Previous](@previous)

import Foundation
import UIKit
//: ### 런타임 에러 처리하기

// Swift는 예상 할 수 있는 오류에 대처하기 위해 몇가지 에러 복구 기능을 제공한다.
// 옵셔널 값도 에러 처리에 도움을 줄 수 있는 부분이지만, 정확한 이유는 모른다.
// 따라서, 해당하는 사유를 명확히하고 적절한 대처를 할 수 있게 하는 것이 에러 처리의 목적이다.
// * 참조 : Adopting Cocoa Design Patterns https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html#//apple_ref/doc/uid/TP40014216-CH7-ID10

// Swift 에서는 4가지의 에러 처리 방식을 제시한다.
// 호출된 계층에 따라 에러 전달하기, do-catch, nil 값 이용하기, assert 이용하기

// ❊ Swift 의 try-catch 는 다른 언어와 비슷해 보이지만, 다른 언어처럼 콜 스택을 되감지는 않는다. 대신 return 과 비슷한 행위를 한다.

//: ### 1. Throwing 함수를 통해 에러 전파하기
// 런타임 에러가 발생 했을 때, 명시적으로 에러를 표시하기 위해 Throw를 이용한다.
// Syntax : 타입 선언 전에 throws 키워드 명시 : func canThrowErrors() throws -> String

//: ![try-catch](do-try-catch.jpg "Try catch 문법")

// 1단계. Error 정의하기
enum FuncError : Error {
    case TooBig, ErrorForError
}
// 2단계. 런타임 에러 발생 시 에러를 throw 하는 함수 만들기
func errorWhenOverTen(_ value:Int) throws {
    if value < 10 {
        print("everything is ok")
    }
    else {
        throw FuncError.TooBig
    }
}
// 3단계. do-try-catch 구문 이용하기
do {
    try errorWhenOverTen(101)
} catch FuncError.TooBig {
    print("Error catched : \(FuncError.TooBig)")
}

//: ### 에러를 nil 로 치환하기

// 파라미터가 1이 아니면 에러를 반환하는 함수.
func someThrowingFunction(oneOrError number:Int) throws -> Int {
    if number != 1 {
        throw FuncError.ErrorForError
    }
    return 1
}

//: try?
let x = try? someThrowingFunction(oneOrError: 2)


func fetchDataFromDisk() -> Data? {
    return nil
}
func fetchDataFromServer() -> Data? {
    return nil
}
// try? 를 이용하면 좀 더 명확하게 구문을 작성 할 수 있다.
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}

let willbenil = fetchData()

//: do-try-catch 문 이용하기
let y: Int?
do {
    y = try someThrowingFunction(oneOrError:  100)
} catch {
    y = nil
}

//: ### 에러 전파 막기
// 어떤 경우는 함수가 어떤 에러도 throw 하지 않는 경우가 있다는 걸 알 수 있다.
// try! 를 이용해서 반환값이 nil 이 아님을 확정해고, 에러 전파 시스템이 동작하지 않도록 할 수 있다.
// 단, 이 때도 nil 값이 생긴다면 런타임 에러가 발생한다.
let photo = try! UIImage.init(named: "./Resources/John Appleseed.jpg")


//: ### assert 구문 이용하기

let age = -3
//assert(age >= 0, "age can't not be under 0")

// -Ounchecked 을 끄면 precondition 은 컴파일러에서 체크하지 않게 됨.
//precondition(age >= 0, "age must be over 0")

//: ### Rethrowing Functions and Methods
// 함수의 파라미터 중에서 에러를 throw 하는 것이 있을 때만 에러를 throw 한다는 것을 명확히 하기 위해 rethrow 키워로 선언 할 수 있다. 이런 유형의 함수나 메소드를 rethrowing function, rethrowing method 라고 한다. Rethrow 함수(메소드)는 최소 한개 이상의 '에러를 throw' 하는 파라미터를 가져야 한다


//: ### 또다른 자원 해제 방식
// ARC 시스템에 따라 자원이 해제 될 수 있는데, 그것 외에 블록 내에서 안전하게 자원 해제를 명시적으로 할 수있는 방법이 있다.
// defer { } 구문을 이용하는 것인데, defer 블록 안의 내용은 함수 내에서 순차적으로 실행 되는 것이 아니라, 코드 블록이 끝나고 난 후에 불려진다.( return, break ) 에러가 예상 되는 곳에 같이 쓰면, 에러 발생 전후의 자원 할당과 해제 코드가 뭉칠 수 있으므로 코드 응집도가 높아진다.
// defer 가 블록 내에 여러개 등장하면 동작 순서는 FILO 이다. 가장 처음에 등장한 defer 구문이 가장 마지막에 실행된다.

// 아래 코드 예제처럼 파일을 열고, 모든 작업이 끝나면 파일을 닫아야 하는데 함수가 어떻게 되든 함수가 끝나면 파일이 닫히도록 보증해준다. 또한, 파일을 여는 코드와 파일을 닫는 코드가 가까이 위치해 있어 가독성도 증가한다.
//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // Work with the file.
//        }
//        // close(file) is called here, at the end of the scope.
//    }
//}
//: [Next](@next)
