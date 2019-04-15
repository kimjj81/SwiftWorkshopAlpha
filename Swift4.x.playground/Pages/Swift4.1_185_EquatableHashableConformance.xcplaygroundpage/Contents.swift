import Foundation

//: # Synthesizing Equatable and Hashable conformance
//: https://github.com/apple/swift-evolution/blob/master/proposals/0185-synthesize-equatable-hashable.md

//: Equatable과 Hashable 를 위해 많은 중복 코드 작성이 필요하다. 컴파일러 차원에서 이를 제거하기 위한 방안을 제시한다.
//: 다시 얘기하면, Equatable, Hashable 선언하면 그 외의 코드는 자동으로 컴파일러에서 처리해준다.
//: 아래 예제들은 이러한 문제를 보여준다.

struct Person: Equatable {
    var firstName:String
    var lastName:String
    var birthDate:Date
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.birthDate == rhs.birthDate
        //...
    }
}

enum Token: Equatable {
    case string(String)
    case number(Int)
    case lparen
    case rparen
    
    static func == (lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case (.string(let lhsString), .string(let rhsString)):
            return lhsString == rhsString
        case (.number(let lhsNumber), .number(let rhsNumber)):
            return lhsNumber == rhsNumber
        case (.lparen, .lparen), (.rparen, .rparen):
            return true
        default:
            return false
        }
    }
}

//: 한편 아래처럼 enum 에 값이 할당되어 있지 않으면, 기본적으로 Equatable, Hashable Conformance 를 제공한다.

enum Foo {
    case zero, one, two
}

let x = (Foo.one == Foo.two)  // evaluates to false
let y = Foo.one.hashValue     // evaluates to 1

//: Overriding synthesized conformances
// 오버라이드 허용
struct Bad<T>: Equatable {
    // synthesis not possible, T is not Equatable
    var x: T
}

struct Good<T> {
    var x: T
}
extension Good: Equatable where T: Equatable {} // synthesis works, T is Equatable

//: 컴파일러에서 Equatable, Hashable 을 자동으로 Conformance 하기 위한 고려 사항들

//: enum 에서 고려 사항
//: 1. case 가 없는 것은 불가능하다.
//: 2. 1개 이상의 case 가 있고, 이 값들이 모두 Equatable, Hashable 을 Conformance 한 경우.

//: struct 에서 고려사항
//: 구조체에서는 오로지 '인스턴스 저장형 프로퍼티'만 관련이 있다. static 이나 계산된 프로퍼티는 고려 사항이 아니다.
//: 저장형 프로퍼티가 없을 경우, 어떤 구조체의 인스턴스는 모두 Equtable, Hashable 을 만족한고 판단한다.

//: 재귀적 타입 : 기본적으로 자동으로 적용 된다. 단, 멤버들이 모두 Equatable, Hashable 해야하며, 하나라도 안될 경우 불가능하다.



//: [Next](@next)
