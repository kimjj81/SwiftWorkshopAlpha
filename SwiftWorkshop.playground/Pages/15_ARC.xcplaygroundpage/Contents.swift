//: [Previous](@previous)

import Foundation

//: ### ARC Automatic Reference Counting

// 레퍼런스 타입(클래스)의 인스턴스의 생성과 소멸을 관리하기 위한 기법
// 자동으로 관리되므로 일반적인 상황에서는 몰라도 되는 부분이지만
// 두 인스턴스간 상호 참조로 인한 참조 순환 고리가 만들어지거나
// 클로저에서 self 를 캡쳐해서 레퍼런스 카운트가 해제가 안되는 경우가 있다.
// 이것이 메모리 누수로 이어지고 의도치 않은 동작까지 야기 할 수 있다.

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?
reference1 = Person(name: "John Appleseed")
reference2 = reference1
reference3 = reference2

reference2 = nil
reference3 = nil

reference1 = nil



//: [Next](@next)
