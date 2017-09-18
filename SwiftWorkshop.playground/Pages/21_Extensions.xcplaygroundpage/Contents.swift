//: [Previous](@previous)

import Foundation

//: ## Extensions
// 이미 존재하는 클래스, 구조체, 열거형 또는 [프로토콜] 타입에 새로운 기능을 추가하는 방법이다.
// 소스코드가 없는 것에도 적용 가능하다.(Objective-C 에서는 Extension 은 소스코드가 있을 경우이고, Cateogry 는 소스코드가 없는 경우 확장하는 것을 칭한다. Objective-C 의 Extension은 Category 의 일종이며 Extension(익명의 Category) 에는 프로퍼티 추가가 가능했다.)

/*:
 * 계산형 타입 프로퍼티와 인스턴스 프로퍼티 추가 가능
 * 타입 메소드와 인스턴스 메소드 정의 가능
 * 새로운 생성자 추가
 * Subscript(첨자 연산자) 선언
 * 새로운 내포 타입을 선언하고 사용하기
 * 기존 타입의 프로토콜 구현
*/

//: #### 안되는 것
/*:
 * Override 불가
 * 저장형 프로퍼티 추가 불가
 * 프로퍼티 감시자 추가 불가
*/

//: ##### Syntax
// extension SomeType { ...새 기능 추가... }
// extension SomeType : OneProtocol, OtherProtocol { ...프로토콜 구현... }

//: ### 계산형 프로퍼티
// Double 에 km, m , cm, mm, ft 프로퍼티를 추가한 예제

extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")

//: ### 생성자
// Extension 을 통해 생성자 추가가 가능하다. 클래스의 편의 생성자도 추가 가능하다.
// 그러나 새로운 지정 생성자와 소멸자는 추가 할 수 없다. 이것들은 항상 원본 소스에서 정의 해야 한다.
// ❊ 만약 값 타입에 생성자가 정의되지 않았었고, 새로운 생성자를 추가 하는데 모든 값을 초기화 하도록 작성한다면 여전히 기본 생성자와 memberwise 생성자를 이용 할 수 있다. 이런 견지에서 값 타입은 생성자를 추가 할 때 extension 을 이용 하는 것이 편리하다.

// 값 타입 예제 생성자 추가 예제.
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))
let extensionRect = Rect.init(center: Point.init(x: 0, y: 0), size: Size.init(width: 100, height: 100))


//: #### 메소드 추가

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}

//: #### Mutating Instance Method
// ❊ 값 타입에서 프로퍼티를 변경하는 메소드에는 mutating 한정자를 붙여야 한다.
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()
// someInt is now 9

//: #### Subscripts - 첨자 연산자
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
746381295[0]
// returns 5
746381295[1]
// returns 9
746381295[2]
// returns 2
746381295[8]
// returns 7

//: #### 내포 타입

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}
func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])

//: [Next](@next)
