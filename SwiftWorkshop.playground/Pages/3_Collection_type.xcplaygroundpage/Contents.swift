//: 다양한 집합들

import Foundation
import UIKit

//: 집합 타입
//: ![집합 타입](Collection_Types.jpg "집합 타입")

// Array - 순차적인 집합. 값 중복 가능.
// Set - 순서가 없는 집합. 값 중복 없음.
// Dictionary - [Key, Value] 쌍으로 이루어진 값. Key는 Hashable 을 구현. 키 중복 없음. 값 중복 가능.

//: Mutable vs Immutable
// mutable : var 로 선언. 집합의 구성 요소 변경 가능
// immutable : let 으로 선언. 집합의 구성 요소 변경 불가.
// mutable, immutable 은 최적화, 동시성 프로그래밍에 영향을 줌.

let hetegeneousArray:[Any] = [1,"234",123.102]
type(of:hetegeneousArray)
var mutableArray = ["김","밥","단무지","햄","시금치","계란"]
type(of: mutableArray)

var intArray = [Int]()
for i in 1...5 {
    intArray.append(i)
}

// 두 배열 합치기
var joinedArray = ["kiss","touch","breathe"] + ["icecream","butter","tomato"]
joinedArray += ["sigh"]
joinedArray[2...4] = ["alpha","beta"]


//: Array 순회하기 (iterator)
// for-in
for item in joinedArray {
    print(item)
}

// enuerated()
for (index, item) in joinedArray.enumerated() {
    
        print("\(index) = \(item)")
    
}

//: Dictionary
// Dictionary의 모든 Key 는 같은 타입이어야 하고, 모든 값들도 같은 타입이어야 한다.

var simpleDictionary:Dictionary<String,Any> = Dictionary.init()
simpleDictionary = [String:Any]()

simpleDictionary = [:]
simpleDictionary = ["key":"value","name":"김정진"]

// 변경
let aValue = simpleDictionary["key"] = "golden key"
print("aValue = \(aValue)") //<- 첨자연산자는 반환값 없음
let oldValue = simpleDictionary.updateValue("갑부", forKey: "name") // updateValue는 이전값 반환
print("old value = \(oldValue)")
print(simpleDictionary)

// 반복
for (key,value) in simpleDictionary {
    print("\(key) : \(value)")
}

for value in simpleDictionary.values {
    print("value : \(value)")
}

for key in simpleDictionary.keys {
    print("key : \(key)")
}

//: Set
// Set의 값들은 Hashable 을 구현해야 한다. Hashable은 hashValue 와 Equatable 의 == 을 구현하는데, 이것을 통해 같은 값인지 판별한다.

var letters = Set<Character>.init()
"abcdefgabc 012d82381273801".characters.map{ $0 }.forEach{ letters.insert($0) }
print(letters)
letters = []
print(letters.isEmpty)
//: Set 연산자
let setOperations = #imageLiteral(resourceName: "swift_set_operations.jpg")

