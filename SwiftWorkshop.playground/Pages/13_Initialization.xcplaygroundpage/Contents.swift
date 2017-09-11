//: [Previous](@previous)

import Foundation
import UIKit
//: 생성자

// 생성자는 Class, Structure, Enumeration 인스턴스가 생성 될 때 호출되는 초기화 구문인데, Class 의 생성자는 상당한 규칙을 갖고 있다. 아래에 정리해 둔 것이 있으니 참조하기 바랍니다.
// 생성자 https://windroamer.wordpress.com/2017/08/24/swift-%EC%83%9D%EC%84%B1%EC%9E%90/

//: Syntax

// init { } :  리턴 값을 지정하지 않고, func 수식어도 없음

struct Fahrenheit {
    var temperatureInCelsius: Double
    init() {
        temperatureInCelsius = 32.0
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperatureInCelsius)° Fahrenheit")

// 기본값 지정하기. 이때는 '감시자'가 발생하지 않음.
struct Celcius {
    var temperature : Double = 20
}

// 생성자에 아규먼트 레이블과 파라미터 이름 사용하기

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
}

//: 지정 생성자와 편의 생성자

// init 앞에 convenience 수식어가 붙으면 편의 생성자이고, 아무것도 없으면 지정 생성자이다.
// 일반적으로 지정 생성자는 1개 정도이다.(강제사항은 아님)
// 또한 편의 생성자는 파라미터가 없거나 적은 것이다.

//: 생성자 호출 구조.
//: ![생성자 호출 구조 ](initializer_delegation_jpg.jpg "생성자 호출 구조")

//: 생성자 규칙
//
//지정 생성자는 직전 수퍼 클래스의 지정 생성자를 호출 해야 한다.
//편의 생성자는 같은 클래스의 다른 생성자를 반드시 호출 해야 한다.
//편의 생성자는 최종적으로 지정 생성자를 호출 해야 한다.
//다시 말하면
//
//지정 생성자는 하위 클래스에서 상위 클래스를 호출하며 (super.init 호출)
//편의 생성자는 ‘같은 클래스’ 내에서 호출이 이루어 진다. (self.init 호출)


//: 생성자 2단계
//
//인스턴스가 생성 될 때는 2 단계를 거친다.
//
// 1. 현재 클래스의 모든 저장형 프로퍼티 초기화(선언부에서 초기값 지정)
// 2. 1번이 끝난 후, 필요한 작업을 수행(customize)하고 인스턴스를 사용 할 수 있게 한다.

//: 생성자 규칙 체크 (Safety Check)
//
//  컴파일러는 위 규칙을 정확히 적용 했는지 알려준다. 아래 규칙을 위반하면 컴파일러 에러가 발생한다. 이 규칙들을 살펴보면 한 프로퍼티가 최종적으로 내가 의도한 값이 아닌 다른 값을 가지게 되는 것을 방지하기 위함이다.
//
//  1. 수퍼클래스의 지정 생성자를 호출하기 전에(super.init) 해당 클래스의 모든 프로퍼티가 초기화 되어야 한다.
//    = 지정 생성자에서 해당 클래스의 모든 프로퍼티가 초기화 되어야 한다.
//  2. 수퍼 클래스에서 상속받은 프로퍼티의 값을 서브 클래스(의 지정 생성자)에서 변경하기 전에, 이미 수퍼 클래스의 지정 생성자가 호출 되었어야 한다. 왜냐하면 서브 클래스의 지정 생성자에서 상속받은 프로퍼티의 값을 변경한 후 1번 규칙에 따라 수퍼 클래스의 생성자를 호출하면 서브 클래스에서 호출한 부분이 덮어 씌여질 수 있기 때문이다.
//  올바른 순서 : super.init() …. -> 상속받은 프로퍼티 수정
//  잘못된 순서 : 상속받은 프로퍼티 수정 -> super.init()
//  3. 편의 생성자의 가장 처음 동작은, 다른 생성자를 호출하는 것이다.
//  4. 생성자 2단계 중 1단계가 지나기 전에는 다음과 같은 일을 하지 못한다. (그 후에 가능하다는 이야기)
//   4-1. 인스턴스의 다른 메소드 호출
//   4-2. 인스턴스의 다른 프로퍼티 읽기
//   4-3. self 이용하기



//: 실패 가능한 생성자

var failureExample:Int? = Int.init("123")
print(failureExample)


//: Required 생성자

// 모든 서브 클래스에서 해당 생성자를 구현해야 함. 단, 자동 생성 규칙을 만족시켰다면 안해도 됨.




//: [Next](@next)
