//: 열거형

// 다른 언어와 다르게 Int, String, 부동소수 , 복합형 등등을 rawValue로 쓸 수 있다. 또한, property, method, extension, protocol 등등 모두 사용 가능. 아주 강력해짐. value-type
import Foundation

//: 일반적인 형태.
enum 방위 {
    case 동,서,남,북
}

print(방위.북.hashValue)

//: RawValue 를 숫자가 아닌 String, 복합형, 숫자, 실수형 등등 다른 값을 쓸 수 있다.
//: 다른 값을 쓰기
enum 꽃이름 : String {
    case camomaile = "국화"
    case sunflower = "해바라기"
}

print(꽃이름.camomaile)
print(꽃이름.camomaile.rawValue)

var 해바라기 = 꽃이름.init(rawValue: "해바라기")
//var 수선화:꽃이름 = 꽃이름.init(rawValue: "수선화")!
//print(수선화)

//: 복합 타입
enum 드라이버 {
    case plus
    case flat
    case hammer(volt:Int,w:Int,batteryMinute:Float)
}

var driver = 드라이버.plus
driver = .flat
driver = 드라이버.hammer(volt: 5, w: 300, batteryMinute: 10)
driver = .hammer(volt: 15, w: 500, batteryMinute: 5)

//: Enum + switch

switch driver {
case .hammer(let volt,let watt, let batteryTime):
    print("\(driver) : \(volt)V \(watt)W \(batteryTime) Min(s)")
default:
    print("\(driver)")
}

//: 묵시적 RawValue 정하기
enum Planet : Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var 행성 = Planet.neptune
print(행성.rawValue)


enum CompassPoint: String {
    case north, south, east, west
}
var direction = CompassPoint.north
print("방위 = \(direction.rawValue)")


//: 재귀적 enum.
//: 자신 안에 자신의 enum 를 만들기 위해 indirect 키워드를 사용함
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpressionOther {
    case number(Int)
    case addition(ArithmeticExpressionOther, ArithmeticExpressionOther)
    case multiplication(ArithmeticExpressionOther, ArithmeticExpressionOther)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))

//: 열거형 + 함수

enum OnoffSwitch {
    case on, off
    mutating func toggle() {
        switch self{
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}

var mainRoomSwitch = OnoffSwitch.off
print(mainRoomSwitch)
mainRoomSwitch.toggle()
print(mainRoomSwitch)

//: 열거형 + Extension
protocol Printable {
    func describe()
}
extension OnoffSwitch : Printable {
    func describe() {
        print("My status : \(self)")
    }
}
mainRoomSwitch.describe()

