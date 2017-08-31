//: 고차 함수 = 파라미터가 함수, 반환 타입이 함수

//: Map, Filter, Reduce, FlatMap

import Foundation

//: Map 컬렉션의 형태를 바꿈

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
var numbers = [16, 58, 510]
// Array 타입에서 Int 형인 것을 알고 있으므로 number 의 타입이 추론 가능하다.
let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
print(strings)

//: Filter 조건에 맞는 컬렉션만 배열로 반환

//: Reduce 합계

//: FlatMap  map + flat + nil 제거

var arrayOfArrays = [ [1, 1], [2, 2], nil, [3, 3] ]

let flattenArrays = arrayOfArrays.flatMap { (arr) -> [Int] in
    if let subArr = arr {
        return subArr.map{ $0 * 2}
    }
    else {
        return []
    }
}

let others = arrayOfArrays.flatMap { $0 }
print(flattenArrays)
print(others)

//: nil 제거 예제 flatMap 예제

struct User {
    let id: Int
    let name: String
    let username: String
    init?(dictionary: Dictionary<String, Any>) {
        guard
        let id = dictionary["id"] as? Int,
        let name = dictionary["name"] as? String,
        let username = dictionary["username"] as? String
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.username = username
    }
}

let users:Array<[String:Any?]>
users = [ ["id":1,"name":"정진","username":"windroamer81" ],[ "id":2,"name":"error","username":nil]]

//let structUsers = users.map{ User.init(dictionary:$0 ) }
//for (index, user) in structUsers.enumerated() {
//    print("\(index) = \(user)")
//}

//let flattenUsers = structUsers.flatMap{ $0 }
//for (index, user) in flattenUsers.enumerated() {
//    print("\(index) = \(user)")
//}
