//: Playground - noun: a place where people can play

import UIKit
import Foundation

//: Type
//: 정수형 Int, Int8, Int16, Int32, Int64
//: 실수형 Double, Float
//: 불린 Bool
//: 문자열 String , Substring, Character, CharacterSet
//: 집합형 Array, Set, and Dictionary


// Value Type initializer vs Reference Type initializer

// 지정생성자는 super.init 을 호출하고, 편의 생성자는 self.init 을 호출한다.
class Food {
    var name: String
    
    // 지정 생성자
    init(name: String) {
        self.name = name
    }
    // 편의 생성자
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

class RecipeIngredient: Food {
    var quantity: Int
    
    // 지정 생성자는 규칙에 의해 super class 의 지정 생성자를 마지막으로 호출한다.
    init(name: String, quantity: Int) {
        // 규칙에 의해 super.init 이 불리기 전에 이번 클래스에서 선언한 모든 저장형 프로퍼티가 지정된다.
        self.quantity = quantity
        // 규칙에 의해 최종적으로 super의 지정 생성자를 호출한다.
        super.init(name: name)
    }
    
    // 편의 생성자는 규칙에 의해 self.init 을 호출한다.
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}
// 위 사례를 보면 수퍼 클래스에서 지정 생성자였던 것이 편의 생성자로 바뀔 수 있다. 지정 생성자를 재정의하였으니 override 키워드를 썼다.

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}



class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let pi = 3.00
let valueChanged = Int(exactly:pi )


enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

enum TemperatureUnit2: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let tempUnit = TemperatureUnit2.init(rawValue: "C")

class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}
class UntitledDocument: Document {
    override init() {
        super.init(name: "Untitled")!
    }
}

// 클로저를 이용한 기본값
class SomeClass {
    let someProperty: String = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return ""
    }()
}

// 클로저와 함수를 이용한 기본값 정하기

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))

var arr = ["abc","123","name","first name last name","workshop"]
print(arr.map { $0 + "~_~" })
print(arr)
print(arr.filter { $0 == "123"})
print(arr.reduce("",{ $0+$1 }))


extension Array where Element == String {
    func searchStrings(using f: (Element) -> String)
        -> [String] {
            var result = [String]()
            for entry in self {
                result.append(f(entry))
            }
            return result
    }
}
public func string(from rawString: String) -> String {
    // returns the search string for iTunes store
//    return rawString.split(separator: Character(" ")).joined(separator: "+") // for Swift 4.x
    return rawString.components(separatedBy: " ").joined(separator: "+")
}

string(from: "food and cooking")

print(arr.searchStrings(using:string))
print(arr.searchStrings{ $0 })
print(arr.map({ (_ s:String) -> String in
    return s + "00"
}))
