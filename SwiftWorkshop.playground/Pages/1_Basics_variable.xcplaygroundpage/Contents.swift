//: 상수와 변수  = let vs var

//: mutable vs immutable?

// 변수명에 유니코드 사용 가능
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"


//let multiline = """
//여러줄은 이렇게 쓸 수 있습니다.
//-_-
// 하지만 swift 3에선 안되지요~ 4 부터 됩니다여러분~
// 줄바꿈 하려면 \ 백슬래시 하나 넣으면 됩니다.
// 들여쓰기 기능도 제공하는데 그건 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285 을 참조하세요.
//"""

let unicode = "\u{1F496}"
// string 과 character 에 대해서는 위 링크의 문서를 더 참조하세요.

//: 기본함수 print()
print ("π = \(unicode)")

//: Type
// 정수형 Int, Int8, Int16, Int32, Int64 (Unsigned 는 지양. Type Safety, Type Inference 참조)

let decimalInteger = 17 // 10진수
let binaryInteger = 0b10001       // 17 의 2진수, 앞에 0b
let octalInteger = 0o21           // 17 의 8진수, 앞에 0o
let hexadecimalInteger = 0x11     // 17 의 16인주, 앞에 0x

// 지수형
let decimalExp1 = 1.25e2 // 1.25 x 10^2, or 125.0.
let decimalExp2 = 1.25e-2 // 1.25 x 10^-2, or 0.0125.

// 16진수 지수형
let hexaExp1 = 0xFp2 //  15 x 2^2, or 60.0.
let hexaExp2 = 0xFp-2 //  15 x 2^-2, or 3.75.

//: 부동소수점
//: - Float 은 최소 6자리의 정수부, Double은 최소 15자리. 왠만하면 Double 사용. (단, swift 만 쓸때. legacy code 없이)
// 실수형 Double, Float
let double1 = 280.01231
let float1 = Float(123.12)

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

// 실수 + 정수 연산
let plusDeciamlDouble = Double(134) + 12.3245

// 불린 Bool
let yes = true
let no = false

//: 이름 치환하기. typealias
typealias AudioSample = UInt16

// 문자열 String , Substring, Character, CharacterSet
// 집합형 Array, Set, and Dictionary
let newArray = [1,2,3,5]
let newSet = Set.init(arrayLiteral: 1,3,5,6,8,1,1,1,1,5,6,1,10)
var newDic = ["key":"value","name":"kim","laptop":"macbook"]
print(newDic)
newDic["key"] = "newValue"
print(newDic)

//: Tuple
let http404Error = (404, "Not Found")

// 분리
let (statusCode, statusMessage) = http404Error
print("status code : \(statusCode) , message : \(statusMessage)")
// 튜플 구성요소에 이름 붙이기
let http200Status = (statusCode: 200, description: "OK")

//: 코멘트
//: // This is a comment.
//: /* This is the start of the first multiline comment.
//:  * This is the second, nested multiline comment. */
//:  This is the end of the first multiline comment. */


//: Safety-Type Language
// 컴파일 시에 변수와 값의 타입이 동일한지 체크한다.

//: 타입 정하기 vs 타입 추론하기
let pi = 3.14159 // double 로 추론
let kimjeongjin:String = "김정진"

//: semicolon
let cat = "🐱"; print(cat)

//: Optional 타입, nil
// nil 은 값이 존재 하지 않는다는 의미. 모든 타입에 가능. Objective-C의 nil 은 레퍼런스 타입에만 가능
var balance:Any? = nil
balance = 100_000
