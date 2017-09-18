//: Class and Structure

// 스위프트에서 class와 structure는 많은 부분이 유사하다

//: 공통점
// 값을 저장하기 위해 프로퍼티 사용
// 메소드 = 소속된 함수
// 첨자 연산자 : ex) array[1] or dictionary["key"]
// 생성자 존재
// 확장 가능성
// protocol 구현

//: 차이점, 클래스만 가진 고유 특성
// 상속
// 형변환을 통해서 런타임에 인스턴스의 타입을 해석하거나 체크 가능
// 소멸자
// 레퍼런스 타입, 레퍼런스 카운팅

import Foundation

struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
    
    var description:String {
        get
        {
            return "<\(resolution.width):\(resolution.height)>, frameRate : \(frameRate) , name = \(name!) "
        }
    }
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

// 프로퍼티 접근 : .
print("The width of someResolution is \(someResolution.width)")
// 인스턴스의 구조체 프로퍼티의 프로퍼티를 바로 수정 가능. Objective-C 에서는 새 구조체 인스턴스 생성했어야 함.
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

//: Value type vs Reference Type
// Value type : Enumeration, Structure 파라미터로 이용 될 때 copy 하게 됨.
// Reference type : Class 파라미터로 이용 할 때, copy가 일어나지 않고 포인터가 이용 됨. Reference Count 존재. Reference Count 가 0 이 되면 해당 인스턴스는 삭제 됨

// Value Type
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2140
print("\(cinema) : \(hd)")

// Reference Type
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

var fourK = tenEighty
fourK.resolution = Resolution(width:3840,height: 2160)
fourK.name = "UHD"
print(tenEighty.description)

// 레퍼런스타입 비교. === , !==
if fourK === tenEighty {
    print ("같음")
} else {
    print ("다름")
}

// Structure 를 선택하면 좋은 경우
// 다른 변수에 대입되거나, 함수의 파라미터로 넘길 때 copy 가 되길 원하는 경우
// 구조체의 프로퍼티는 레퍼런스 타입이 없게 하는 것을 권장
// 상속이 필요 없을 경우
// structure 의 copy 속도가 class 보다 월등히 빠름
// 좀 더 functional language 에 가깝게 프로그래밍 하기 좋음

// 논쟁거리 https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82
// In all other cases, define a class, and create instances of that class to be managed and passed by reference. In practice, this means that most custom data constructs should be classes, not structures.
// -> 여러 프로그래머들은 structure 를 이용하길 권하는 글을 많이 볼 수 있음. structure + protocol

//:  Strings, Arrays, and Dictionaries => Structure
