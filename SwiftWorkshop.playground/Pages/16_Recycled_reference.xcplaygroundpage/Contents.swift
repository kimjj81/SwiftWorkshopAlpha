//: [Previous](@previous)

import Foundation

//: ### 상호 순환 참조 고리 끊기

class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    var apartment: Apartment?
    var car:Car?
    deinit {
        apartment = nil
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
        print("\(unit) apartment is being initialized")
    }
    var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized where \(tenant) lived.")
    }
}

//: Person 과 Apartment 의 순환 참조에 의해서 자원이 해제되지 않는다.
var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
unit4A?.tenant = john
john?.apartment = unit4A

unit4A = nil
john = nil

//: ### weak vs unowned
// weak 는 어느 한 객체가 다른 객체보다 라이프 타임이 짧을 때 사용한다. 반대로, unowned 는 어느 한 객체가 다른 객체와 라이프 타임이 같거나 길 때 사용한다.

// - weak 로 선언된 변수가 소멸되면 ARC 는 자동으로 nil 로 설정해준다. 따라서, weak 는 nil 이 될 수 있기 때문에 var , optional type 으로 해야 한다.
// ARC가 nil 로 변경 할 때 감시자가 호출 되지 않는다.


class Car {
    let model:String
    init(model:String) {
        self.model = model
        print("\(model) car is being initialized.")
    }
    weak var owner:Person?
    deinit {
        print("Car \(model) is being deinitialized owned by \(owner)")
    }
}

var doe: Person?
var s600:Car?

doe = Person(name: "John doe")
s600 = Car(model: "S600 maybach")
doe?.car = s600
s600?.owner = doe

s600 = nil
doe = nil


//: ### unowned
// - unowned 는 반면 값이 꼭 있다고 가정한다. 따라서 nonoptional type 일 때 사용한다.
// unowned는 꼭 메모리에서 해제되지 않은 인스턴스를 참조하고 있어야한다. 이미 해제된 인스턴스를 참조하려 하면 런타임 에러가 발생한다.

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("-- \(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("-- Card #\(number) is being deinitialized") }
}

var gabriel: Customer?
gabriel = Customer(name: "Gabriel Arch")
gabriel!.card = CreditCard(number: 1234_5678_9012_3456, customer: gabriel!)

gabriel = nil

//: [Next](@next)
