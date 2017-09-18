//: [Previous](@previous)

import Foundation

//: # Advanced Operators

// 2장 기본 연산자에 소개한 것 외에 추가적인 더 복잡하고 진보한 연산자에 대해 소개합니다.
// Swift는 C언어와는 다르게 산술 연산에서 오버플로를 하지 않습니다. 오버플로는 에러로 처리 됩니다. 오버플로를 허용하기 위해서 오버플로 연산자를 제공합니다. 사칙 연산자 앞에 &를 붙이면 됩니다. &+, &- 처럼요.
// Swift 에서는 기본으로 제공되는 연산자에 제한되지 않고 스스로 연산자를 만들 수 있습니다.
// 내가 만든 타입에 infix, prefix, postfix, 대입 연산자를 정의해서 쓸 수 있습니다. (+ , -, ++, -- , = 같은 것들)

//: # Bit 연산자
// 같은 자리의 비트끼리 비교 연산하는 것

//: ## 비트 Not 연산자  ~
// 0은 1로, 1은 0으로 변환
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits  // equals 11110000

//: ## 비트 And 연산자  &
// 둘 다 1일 때 1이 되는 연산자
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits  // equals 00111100

//: ## 비트 Or 연산자   |
// 둘 중 하나만 1이면 1
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits  // equals 11111110

//: ## 비트 XOR 연산자
// 둘의 값이 다르면 1, 같으면 0이 되는 연산자
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits  // equals 00010001

//: ## 비트 Shift 연산자 << , >>
/* Unsigned Bit shift 연산자에 대한 규칙
 * 1. 현재 존재하는 비트(1)가 왼쪽이나 오른쪽으로 이동
 * 2. 어느쪽이든 경계를 벗어나는 값은 무시됨
 * 3. 왼쪽으로 이동하면 제일 오른쪽에, 오른쪽으로 이동하면 제일 왼쪽에 0이 추가된다.
 */
//: ![Unsinged Bit shift](unsigned_int_bit_shift.png "Unsinged Bit Shift 결과")

let shiftBits: UInt8 = 4   // 00000100 in binary
shiftBits << 1             // 00001000
shiftBits << 2             // 00010000
shiftBits << 5             // 10000000
shiftBits << 6             // 00000000
shiftBits >> 2             // 00000001

let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC, or 204
let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66, or 102
let blueComponent = pink & 0x0000FF           // blueComponent is 0x99, or 153

//: ## Signed Integer 의 shift
// 정수(=음수,양수,0) 부호(+,-)는 가장 처음 비트가 담당한다. 1이면 음수, 0이면 양수이다.
// 양수인 경우 unsigned integer와 동일하게 동작한다.
// 음수인 경우 2의 보수 형식으로 저장된다. 2의 보수는 부호 비트를 제외한 나머지를 not 연산하고 -1을 한다.

//: ![2의 보수](twocomplement.png)

// 음수 더하기
// 아래 그림처럼 -1과 -4를 더하는 것을 해보자. 일반적인 방시긍로 하면 아래 처럼 나올 것이다.
//: ![두 음수 더하기](sum_negatives.png)

//: 두번째로 2의 보수로 해보자. 
// bit shift를 하면 왼쪽으로 하면 2를 곱하고, 오른쪽으로 하면 2로 나눈 셈이다. 부호가 있는 정수의 shift 연산은 부호가 없는 정수의 shift 연산과 동일하지만 예외적으로 부호 비트는 그대로 유지한다. 이렇게함으로써 부호를 그대로 유지한다.
//: ![부호있는 정수 비트 쉬프트](signed_shift.png)


//: # Overflow 연산자
// Swift 는 오버플로를 에러로 취급한다. 따라서 아래 예제는 오류가 발생한다.
var potentialOverflow = Int16.max
// potentialOverflow equals 32767, which is the maximum value an Int16 can hold
//potentialOverflow += 1 // 이것의 주석을 제거하면 오류가 발생 한다.ㄴ
// this causes an error

// 그런데, 오버 플로가 발생 했을 때 에러로 처리하기 보다는 몇비트를 잘라 냄으로써 에러를 회피하길 원할 수 있다.
// Swift 는 정수 연산에 3개의 오버플로 연산자를 제공한다.

//: 오버플로 연산자
//Overflow addition (&+)
//Overflow subtraction (&-)
//Overflow multiplication (&*)

//: ## Value Overflow
// 숫자는 양수쪽이든 음수쪽이든 넘칠 수 있다.

// 아래 예제는 그림처럼 9비트로 1이 올라갔지만, 8비트 정수형이기 때문에 9비트는 무시 된다.
var unsignedOverflow = UInt8.max
// unsignedOverflow equals 255, which is the maximum value a UInt8 can hold
unsignedOverflow = unsignedOverflow &+ 1
// unsignedOverflow is now equal to 0
//: ![부호 없는 정수의 오버플로](uint8_overflow.png)

// 만약 언더플로가 나면 이렇게 될 것이다. 0에서 1을 빼면 255가 된다.
unsignedOverflow = 0
unsignedOverflow = unsignedOverflow &- 1
//: ![부호 없는 정수의 언더플로](uint8_underflow.png)

//: 부호 있는 정수
// 8비트 정수형의 최소값은 -128 이고 2진수로 0b10000000 표시 할 수 있다.
// 그러면 Int8타입 -128 에서 1을 빼면 127이 된다.
//: ![부호 있는 정수의 언더플로](int8_underflow.png)
var signedOverflow = Int8.min
// signedOverflow equals -128, which is the minimum value an Int8 can hold
signedOverflow = signedOverflow &- 1
// signedOverflow is now equal to 127

// 위와 같이 오버플로를 허용하는 연산자를 통해서 C언어와 같은 결과를 얻을 수 있다.

//: # Precedence and Associativity (선행과 결합)
// Precedence 어떤 연산자가 다른 연산자에 비해 더 빠르게 연산되도록 지정하는 것
// Associativity 같은 선행 수준을 가진 것들을 그룹화 시키는 것

2 + 3 % 4 * 5
// this equals 17

// 관련해서 선행 그룹은 어떻게 조직 되는지 아래 문서에 나와있다.
// https://developer.apple.com/documentation/swift/operator_declarations

//: # Operator Method
// 커스텀 클래스에 사칙 연산자를 결합 시킬 수 있습니다.
// 아래 예제처럼 백터 2개를 더하는 연산자를 만들 수 있습니다.
struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector is a Vector2D instance with values of (5.0, 5.0)

//: ## Prefix, Postfix 연산자
// 문법 : 연산자 선언문에 prefix 와 postfix 를 붙여준다.
// 아래 예제는 벡터의 x,y 값을 역전 시키는 메소드이다.

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative is a Vector2D instance with values of (-3.0, -4.0)
let alsoPositive = -negative
// alsoPositive is a Vector2D instance with values of (3.0, 4.0)

//: ## 복잡한 할당 연산자
extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original now has values of (4.0, 6.0)

//: ## 등호 연산자
// 두 인스턴스를 비교 할 수 있다.
extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}
// Prints "These two vectors are equivalent."

//: ## 커스텀 연산자
// /, =, -, +, !, *, %, <, >, &, |, ^, ?, ~, .(dot) 나 다음 문서에 나와있는 유니코드로 시작하는 것들을 이용해서 연산자를 정의 할 수 있다.  첫글자만 만족하면 다음은 어떤 유니코드가 나와도 괜찮다. 한편 . 으로 시작하는 연산자만 계속해서 . 을 포함 할 수 있다. ?를 쓸 수는 있지만 ? 한글자만 이용해서 정의 할 수는 없다. !를 포함 할 수도 있지만 postfix 연산자는 !나 ?로 시작 할 수 없다.
// https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID418
// 문법 : [ prefix | infix | postfix] opertator [custom opertaor]
// 일단 아래처럼 새로운 오퍼레이터를 선언한다.
prefix operator +++
// 그러면 타입에서 해당 오퍼레이터를 오버로드 할 수 있다.
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled now has values of (2.0, 8.0)
// afterDoubling also has values of (2.0, 8.0)

//: ## Precedence for Custom Infix Operators 커스텀 중간 연산자의 선행순위 정의
// 커스텀 중간 연산자가 어떤 선행 그룹에 들어가는지 명시적으로 지정하지 않으면 기본 그룹에 속한다.
// 또한 삼항 연산자보다 앞선 그룹에 속하게 된다.

// 아래 예제에서는 +- 연산자가 AdditionalPrecedence 에 속한다고 선언 했다.
infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector is a Vector2D instance with values of (4.0, -2.0)



//: [Next](@next)
