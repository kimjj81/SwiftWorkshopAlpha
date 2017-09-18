//: [Previous](@previous)

import Foundation

//: 어느 Class 의 메소드, 프로퍼티, 기타 여러 특성들을 기반으로 새로운 클래스를 만드는 것. Class 만의 고유 기능.

// 기반이 되는 클래스를 SuperClass, 새로 만들어진 클래스는 SubClass 라 칭함.
// 아무것도 상속하지 않은 클래스를 Base Class 라고 함. 
// Swift 는 자동으로 상속되는 SUperClass가 없음.

class Vehicle {
    var currentSpeed = 0.0
    var maxSpeed:Int {
        return 100
    }
    func makeNoise() {
        print("not implemented")
    }
}

class Bicycle : Vehicle {
    var lock = "Very strong lock"
}

let smallBicyle = Vehicle ()
smallBicyle.currentSpeed = 10
print(smallBicyle.currentSpeed)

//: Override
// 이미 정해진 기능을 subclass 에서 바꾸는 것. Swift 에서는 override 키워드를 강제하고 있다.
// super 키워드를 통해 메소드, 프로퍼티, 첨자 연산자 접근 가능.

class Car : Vehicle {
    
    override func makeNoise() {
        super.makeNoise()
        print("Klaxon!!")
    }
}

let mycar = Car()
mycar.makeNoise()

//: Override 프로퍼티

// getter, setter, observing 오버라이드 가능
// ❊ override를 통해서 read-only 를 read-write 으로 변경하는 것은 가능. 반대는 불가.
// ❊ setter를 override 하면 getter 도 반드시 override 해야 함. 대신 getter 에서 super.property 를 반환해서 간단하게 해결은 가능.

class SuperCar : Car {
    override var maxSpeed:Int {
            return 200
    }
}

let mySuperCar = SuperCar()
print("mySuperCar's max speed is \(mySuperCar.maxSpeed)")

//: Override 프로퍼티 감시자

// ❊ 상수형 저장 프로퍼티나 읽기 전용 계산된 프로퍼티는 감시자를 추가 할 수 없다. 왜냐하면 이것들은 변경될 일이 없으므로 willSet 이나 didSet 이 호출 될 일이 없다.
// ❊ 또한, setter 감시자와 프로퍼티 감시자(willSet,didSet)를 동시에 오버라이드 할 수 없다. 왜냐하면 setter 를 오버라이드 하면 프로퍼티의 값이 변경 되는 것을 알 수 있기 때문에 프로퍼티 감시자를 오버라이드 할 이유가 없다.

class AutomaticCar: Car {
    var gear = 1
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

//: final 키워드

// 상속, 오버라이드를 막게 한다.
// final class, final var , final func , final subscript, final class func
//: [Next](@next)
