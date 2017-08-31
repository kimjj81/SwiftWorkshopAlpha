import Foundation

//: 연산자

// 대입 = 연산자는 return 값이 없음. a = b = c 이런식은 안됨.
let mySecretNumber = 486

// 단항(Unary) 연산자
let minusValueOfSN = -mySecretNumber

// 이항(Binary) 연산자
let sum = mySecretNumber + minusValueOfSN
let fullname = "정진" + "김"

// 삼항(Ternary) 연산자
let firstIsBigger = mySecretNumber > minusValueOfSN ? "앞이 큼" : "뒤가 큼"

// 나머지 연산자( Remainder  not modulo)
// 두번째 파라미터를 채워서 두번째 파라미터를 충족하지 못하는 부분이 얼마인지 헤아리는 형식
let remainderPositive = 19 % 4
var remainderNegative = -19 % -4
remainderNegative = 20 % -3
remainderNegative = -15 % 4


remainderNegative += 10
remainderNegative -= 5

1 == 1
2 > 1
2 < 1
100 >= 100
99 <= 99

//: Tuple 비교 연산
// 왼쪽에서 오른쪽으로 진행
(1, "zebra") < (2, "apple") //

(3,345) == (3,12)

(3, "apple") <= (3, "bird")

// ???
(31, 0) > (5, 3)

//: nil제거 연산
var someone:String?
var nilname:String?
var certifiedName = someone ?? nilname
certifiedName = certifiedName ?? fullname


//: 범위 연산자
// ... 연산자 = 경계값 포함
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}

// ..< 미만 연산자 , 증분 연산이기 때문에 초과 연산자는 없음.
for index in 1..<5 {
    print("\(index) * 5 = \(index * 5)")
}

//: Swift4 에서 추가
//let meals = ["밥","소고기","콩","옥수수","빵","파스타"]
//for meal in meals[2...] {
//    print(meal)
//}
//for meal in meals[...4] {
//    print(meal)
//}

//: 반열린 범위 연산자에서 유의 점
//let range = ...5
//range.contains(-1)  // true

//: 논리 연산자, 우선순위 = not > and > or
// not : !a
// and : a && b
// or : a || b

//: 비트 연산자
// & = and, | = or, ^ = exclusive-or

let binary1 = 0b1100_0011
let binary2 = 0b0111_0100

String.init(format: "%X", binary1 | binary2)
String.init(format: "%X", binary1 & binary2)
String.init(format: "%X", binary1 ^ binary2)
