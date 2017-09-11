//: for, if, switch, while, for-in, guard

import Foundation
import UIKit
//: if , optional force unwrapping

var username:String?
//let forceUnwrappedUsername = username!
username = "windroamer81"
if username != nil {
    print("username is \(username!)")
}

//: optional binding
if let age = Int.init(exactly: 10.12983712923187132873120132701272310312701238731208137203128731208371203127312081270312873120731208312730128731201237012387123087120823171230731208712301238712308) {
    print("age is \(age)")
} else {
    print("age is not eligable")
}

//: Forced Unwrapping
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation mark
//: Implicitly optional unwrapping
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation mark

//: for-in
// for item in array
// for (key,value) in dictionary
// for index in 0....5 { }

//: while, repeat-while

var untilTen = 0
while untilTen <= 10 {
    untilTen += 1
    print("while \(untilTen)")
}

var untilZero:Int = 0
repeat {
    untilZero -= 1
    print("repeate \(untilZero)")
} while untilZero >= 0

//: if
var annualSalary = 1_000_000_000

if annualSalary > 100_000_000 {
    print ("넘나 부럽네잉")
} else {
    print ("나도 어떄 연봉 좀")
}

//: if let 을 조합한 nil 체크 패턴과 value-binding
var optionalValue:Any?
if let v = optionalValue { // 이 블록에서 v 라는 변수 선언 됨
    print("optionalValue = \(v)")
} else {
    print("값이 없어부러")
}


//: ### Switch 구문.
//: ![Switch](swift_switch.jpg "스위치 구문")

// switch - fallthrough

var age = 1
switch age {
case 1 :
    print("어려")
    fallthrough
case 2 :
    print("아직도 어려")
    fallthrough
case 5:
    print("말안듣는 5살")
default:
    print("특정 좀 하라고")
}

// Switch-범위 매칭
age = 30
switch age {
case 0...10 :
    print("어린이")
case 11...20 :
    print("10대")
    fallthrough
case 21...40:
    print("질풍노동")
default:
    print("몰라 ㅠㅠ")
}

// Switch-tuple
let somePoint = (0, 0)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

// Switch-Value binding
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}

// Switch-Where 조건문
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}

// Switch - 복합 조건
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}
// 튜플 + 복합 조건 + value-binding
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}


//:continue, break, fallthrough, return, throw

let numberSymbol: Character = "三"  // Chinese symbol for the number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break // 아무것도 안함.
}

//:Labeled Statements - 건너뜀.

//: Guard - Early Exit
func sellAlcohol(whosAge age:Int) -> Bool {
    guard age > 18 else {
        return false
    }
    print("\(age) is over 18, then sellable")
    return true
}

print(sellAlcohol(whosAge: 5))
print(sellAlcohol(whosAge: 20))

//: 기기,환경,OS 호환성 체크

// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Attributes.html#//apple_ref/doc/uid/TP40014097-CH35-ID348
//if #available(platform name version, ..., *) {
//    statements to execute if the APIs are available
//} else {
//    fallback statements to execute if the APIs are unavailable
//}

if #available(iOS 12.0,*) {
    print("iOS 8.0가능")
} else {
    print("안됨 ㅠㅠ")
}
