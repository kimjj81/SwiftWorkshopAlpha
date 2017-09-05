//: [Previous](@previous)

import Foundation

//: Method - 특정 타입과 연결된 함수. Swift 에서는 모든 타입에 메소드를 만들 수 있음.

// self = 자기 자신의 인스턴스를 칭하는 프로퍼티.
class Counter {
    var count = 0
    func increment() {
        self.count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
    func set(count count:Int) { // 파라미터 이름과 프로퍼티 이름이 같을 경우 명시적으로 self 를 이용해서 프로퍼티와 파라미터를 구분해준다.
        self.count = count
    }
    
}

// mutating method : 원칙적으로 값 타입은 인스턴스 메소드에서 자신의 프로퍼티를 수정 할 수 없다. 
// 예외를 주기 위해서 Value Type 은 자신의 프로퍼티를 수정하는 메소드에 mutating 이라고 적어줘야 한다.
// 또한 mutating 메소드는 self 로 자신을 새 값으로 갈아치울 수 있다.
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
    
    mutating func reset() {
        x = 0.0
        y = 0.0
    }
    
    mutating func reset(x x:Double,y y:Double) {
        self = Point.init(x: x, y: y)
    }
}

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

// Class 에서는 class 키워드를 이용하면, 서브 클래스에서 override 가 가능하다. 만약 static 으로 선언하면 override 가 불가능하다.
class SomeClass {
    class func someTypeMethod() {
        print("someTypeMethod")
    }
}
class OtherClass : SomeClass {
    static override func someTypeMethod() {
        print("inherited type method")
    }
}
SomeClass.someTypeMethod()
OtherClass.someTypeMethod()

//: [Next](@next)
