//: [Previous](@previous)

import Foundation

//: ### Optional Chaining, 옵셔널 체이닝

// Optional Chaining 이란 nil 값일 수 있는 옵셔널 타입의 인스턴스의 프로퍼티, 메소드, 첨자 연산자를 연속해서 호출하는 것이다. 예) john?.apartment?.refrigerator?
// 만약 인스턴스가 nil 이거나, 연속된 호출 중에 nil 이 있으면 에러 없이 nil 을 반환한다.

//: ### Force Unwrapping 대신 사용하는 옵셔널 체이닝
// Force Unwrapping ( ! ) 과 Optional Chaining ( ? ) 의 차이는 Force Unwrapping 은 nil 이면 런타임 에러를 발생시키고, Optional Chaining 은 단지 nil 을 반환하거나 아무 일을 하지 않는다.
// 옵셔널 체인에 중간에 옵셔널 타입이 아닌게 있어도 최종적인 결과는 옵셔널 타입이 반환된다.

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

// 아래 주석을 지우면 에러가 날 것이다.
//let roomCount = john.residence!.numberOfRooms

// 아래 코드는 에러가 없으며, 연쇄적인 호출 단계에 옵셔널 타입이 있고, nil 값이 있으므로 결과적으로 nil 을 반환한다.ㄴ
let otherRoomCount = john.residence?.numberOfRooms

// 4_Control_Flow 에서 옵셔널 타입을 안전하게 사용 하는 방법을 배웠다.
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

//: ### 옵셔널 체이닝을 위한 모델 클래스 작성하기
// 아래 예제는 옵셔널 타입을 가진 복잡한 클래스 예시이다.
// Hotel 은 여러 Room 이 있을 수 있고, 주소도 있을 수 있다.
// Address 는 건물 이름, 건물 번호, 도로명 속성이 있고, 주소를 잘 표현할 수 있는 메소드를 하나 제공한다.

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Hotel {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

class HotelPerson {
    var hotel:Hotel?
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"

var hilton = HotelPerson()

// 프로퍼티 옵셔널 체이닝
if let roomCount = hilton.hotel?.numberOfRooms {
    print("- Hilton's residence has \(roomCount) room(s).")
} else {
    print("- Unable to retrieve the number of rooms.")
}

hilton.hotel?.address = someAddress


// Subscripting 에 옵셔널 체이닝
if let firstRoomName = hilton.hotel?[0].name {
    print("-- The first room name is \(firstRoomName).")
} else {
    print("-- Unable to retrieve the first room name.")
}


// 다른 첨자 연산자(Subscripting) 예제
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72 // Brian key 에 해당하는 인스턴스가 없으므로 nil 을 반환.

//: ### 멀티 레벨 엮어보기

// 여러 단계를 거치는 옵셔널 체인이 생성되면
// 1. 옵셔널 체인을 통해서 옵셔널 타입이 아닌 값을 접근하면 최종적으로 옵셔널 타입이 반환된다.
// 2. 이미 옵셔널인 것은 계속 옵셔널 타입으로 반환된다.

// 아래 예제에서 마지막 street 는 optional 타입이 아니지만 optional 타입으로 반환된다.
if let hiltonsStreet = hilton.hotel?.address?.street {
    print("---- Hilton's street name is \(hiltonsStreet).")
} else {
    print("---- Unable to retrieve the address.")
}

// 최종 결과가 nil 인 것을 볼 수 있다.
let repeatAgain = hilton.hotel?.address?.street

//: 메소드에 옵셔널 체이닝 적용해보기
if let buildingIdentifier = hilton.hotel?.address?.buildingIdentifier() {
    print("----- Hilton's building identifier is \(buildingIdentifier).")
} else {
    print("----- 어딘가 nil 이 있다.")
}

//: [Next](@next)
