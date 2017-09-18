//: [Previous](@previous)

import Foundation

//: Subscripts (첨자 연산자) : Collection, List, Sequence 형식 인스턴스의 멤버에 접근하기 위한 축약 형식.

// 첨자 연산자 의 반환값은 어떤 타입이라도 가능하고, 파라미터도 마찬가지다. 파라미터가 1개 이상 있어도 되고, 가변 파라미터( ... ) 도 가능.
// 다만, inout 파라미터, 기본값이 지정된 파라미터는 불가능하다.

// ex: array[1], dictionary["name"]

class SubscriptExamClass {
    subscript(index: Int) -> Int {
        get {
            // return an appropriate subscript value here
            return 0
        }
        set(newValue) {
            // perform a suitable setting action here
            
        }
    }
}



//: [Next](@next)
