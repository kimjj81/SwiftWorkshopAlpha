//: [Previous](@previous)

import Foundation

//: 프로토콜의 연관타입(associated type) 강화를 위한 정의이다. associatedtype 의 재귀적 용법이 가능하게 한다.
//: https://github.com/apple/swift-evolution/blob/master/proposals/0075-import-test.md  


//: 암튼 예제부터.
//: 마트료시카라는 러시아 인형은 인형 안에 또 인형이 들어 있다.
protocol RussianToy {
    associatedtype SubToys: RussianToy
    var toys:[SubToys] { get set}
}

class Матрёшка : RussianToy{
    var toys = [Матрёшка]()
}


//: 재귀적인 용법이 4.0 이하에선 안됐다.
protocol Sequence {
    associatedtype SubSequence: Sequence
        where Iterator.Element == SubSequence.Iterator.Element, SubSequence.SubSequence == SubSequence
    
    // Returns a subsequence containing all but the first 'n' items
    // in the original sequence.
    func dropFirst(_ n: Int) -> Self.SubSequence
    // ...
    
}

//: 그러나 이제는 된다.
//: 이전에는 이렇게 했어야 한다.
//protocol Sequence {
//    // SubSequences themselves must be Sequences.
//    // The element type of the subsequence must be identical to the element type of the sequence.
//    // The subsequence's subsequence type must be itself.
//    associatedtype SubSequence
//
//    func dropFirst(_ n: Int) -> Self.SubSequence
//    // ...
//}
//
//struct SequenceOfInts : Sequence {
//    // This concrete implementation of `Sequence` happens to work correctly.
//    // Implicitly:
//    // The subsequence conforms to Sequence.
//    // The subsequence's element type is the same as the parent sequence's element type.
//    // The subsequence's subsequence type is the same as itself.
//    func dropFirst(_ n: Int) -> SimpleSubSequence<Int> {
//        // ...
//    }
//}
//
//struct SimpleSubSequence<Element> : Sequence {
//    typealias SubSequence = SimpleSubSequence<Element>
//    typealias Iterator.Element = Element
//    // ...
//}

//: https://academy.realm.io/kr/posts/try-swift-soroush-khanlou-sequence-collection/ 이 자료에서, 중간에 eachPair() 부분을 해결한 것이 바로 이것이다.

//: [Next](@next)
