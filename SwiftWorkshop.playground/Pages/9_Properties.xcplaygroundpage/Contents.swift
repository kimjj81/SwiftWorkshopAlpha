//: Property

// 열거형, 클래스, 구조체의 인스턴스와 연관된 값. 저장형 프로퍼티, 계산형(Computed) 프로퍼티
// 열거형은 계산형 프로퍼티만 가질 수 있음.
// Type property = 클래스 멤버 변수
// 프로퍼티는 사실상 변수, getter, setter 의 모음이라고 할 수 있다.

import Foundation

//: 저장형 프로퍼티

struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

//: 지연된 저장형 프로퍼티 (Lazy stored property)

// 처음으로 사용되기 전까지 초기화를 하지 않는 프로퍼티
// ❊ 지연된 프로퍼티는 var 로 지정해야 한다. 왜냐면 상수는 초기화가 끝나는 시점에서 값이 정해져 있어야 하기 때문이다.
// ❊ 멀티 쓰레드 환경에서 지연된 프로퍼티가 단 1번만 초기화 된다는 보장이 없다.

class DataImporter {
    var filename = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

print(manager.importer.filename) // 이 시점에서 DataManager의 importer 프로퍼티가 생성 됨.

//: 계산형 프로퍼티(Computed Property)

// getter 와 setter 를 재정의해서 사용

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) { //newCenter는 생략 가능. 묵시적으로 newValue 라는 파라미터로 접근 가능
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
print("square.origin's initial value at (\(square.origin.x), \(square.origin.y))")
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

//: 읽기 전용(계산형) 프로퍼티.
struct Cuboid {
    var volume: Double {
        return width * height * depth
    }
    var width = 0.0, height = 0.0, depth = 0.0
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")

//: 프로퍼티 감시하기(Observing)

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200

// 수퍼 클래스의 감시자는 수퍼클래스의 생성자가 실행된 후에 서브 클래스의 생성자 안에서 값이 설정 될 때 호출 된다.
// 참조 - 생성자 https://windroamer.wordpress.com/2017/08/24/swift-%EC%83%9D%EC%84%B1%EC%9E%90/

// in-out 파라미터를 호출하는 함수에서는 마지막에 파라미터에 데이터를 저장하므로, 항상 감시자가 호출 된다.

//: 타입 프로퍼티

// 타입(클래스, 구조체, 열거형) 자체에 연관된 프로퍼티. 일반적으로 다른 언어에서 클래스 멤머 변수라고 하는 것.
// 저장형 인스턴스 프로퍼티와는 다르게 선언부에서 초기값을 입력하길 강제하며, 항상 lazy 저장형 프로퍼티이다. 또한, 멀티쓰레드 환경에서도 오직 1번만 초기화 되는 것을 보장한다. 그러나 lazy 수식어를 붙이지 않는다. 
// 프로퍼티 앞에 static 키워드를 수식해주면 된다.
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
}
