//: [Previous](@previous)

import Foundation

//: # 프로토콜에서 제공하는 '소유권' 예약어 제거.
//: https://github.com/apple/swift-evolution/blob/master/proposals/0186-remove-ownership-keyword-support-in-protocols.md

//: # 프로토콜 프로퍼티의 weak, unowned 키워드를 제거했다.
//: 그러니 프로토콜에 weak, unowned 를 쓰면 안된다.

//: # 출발점
//: 아래 같은 경우를 보자
class A {}

protocol P {
    /* weak */ var weakVar: A? { get set } // no more weak
}

class B: P {
    var weakVar: A? // weak 키워드를 쓰지 않았지만, 컴파일러에서 error나 warning 을 띄우지 않는다.
}

//: 컴파일러에서는 아무런 경고를 보내지 않지만 사용자 관점에서 예측하지 못하고 끔직한 결과를 이끌 수 있다. 프로토콜 입장에서는 의미 없지만 프로토콜을 채용 할 때는 영향이 있는 것 같아 보인다.
//: swift 3,4에서는 warning 을 낼 것이다. 코드가 깨지진 않지만 제거하는것을 추천한다.

#if canImport(UIKit)
print("UIKit oK")
#else
print("UIKit no")
#endif
//: [Next](@next)
