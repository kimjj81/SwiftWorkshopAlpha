//: [Previous](@previous)

import Foundation

//: # Access Control : 접근 제어

// 특정 부분을 다른 모듈이나 파일에서 접근하지 못하도록 제어하는 것이다. Encapsulation
// 자신이 정의한 구조체, 열거형, 클래스 같은 개별 타입 뿐만 아니라, 프로퍼티, 펑션, 메소드, 생성자, 첨자 연산자 각각에 다르게 적용 가능
// 프로토콜은 전역 상수, 변수, 함수와 같은 특수한 경우에 대해서도 제약이 가능하다

// 스위프트가 다양한 수준의 접근 제어를 제공하지만, 하나의 타겟만 가진 앱에서는 필요 없을 수도 있다.

//: ## Modules and Source files

// Module - 코드가 배포되는 하나의 단위. App, Framework 가 될 수 있고, 다른 앱에 의해 import 될 수 있다.
// 앱 번들이나 프레임워크같은 각각의 빌드 타겟은 스위프트에서는 분리된 모듈로 취급한다. 
// Source file - 모듈 내의 한개의 소스 파일(.swift) 이다. 일반적으로 하나의 파일에 하나의 타입을 정의하지만, 하나의 파일에 여러 타입이나 함수 등등을 정의 할 수 있다.

//: # 접근 수준(Access Level)

/*
 * open, public - 어느 소스파일이나 모듈을 import 한 곳에서 접근 가능하도록 한다. 일반적으로 프레임워크의 공개된 부분에 사용한다.
 * internal - 정의된 모듈에서만 사용 가능하고, 다른 곳에서는 사용하지 못 하게 한다. 일반적으로 앱이나 프레임워크 내부용으로만 사용 할 때 이용한다.
 * fileprivate - 선언한 소스 파일 내부에서만 사용 가능하도록 한다.
 * private - 선언한 곳 내부에서만 사용 가능하도록 한다. 만약 Extension 에 사용하면 해당 파일 내부에서만 사용 가능하다. 
 * open > public > fileprivate > private 순으로 개방도가 높다.
*/


//: ## open 과 public 의 차이
// open 은 클래스와 그 멤버에만 적용 가능하며, public 은 다른 타입에도 적용 가능하다.
/* open 이 가장 개방적이며, public 은 그 다음 수준이다.
 * 1-1 public 이나 그보다 제약이 심한 수준으로 선언된 클래스는, 해당 클래스가 정의된 모듈 내에서만 상속이 가능하다.
 * 1-2 open은 해당 모듈과 그것을 import 한 모듈에서 상속이 가능하다.
 * 2-1 public 이나 그보다 제약이 심한 수준으로 선언된 클래스 멤버는, 해당 클래스가 정의된 모듈 내에서만 상속과 재정의(override)가 가능하다. 
 * 2-2 open 으로 선언된 클래스 멤버는 해당 모듈과 import 한 모듈에서 상속을 통해 override 가 가능하다.
 */
// 클래스를 open 으로 선언하는건 두가지를 명시적으로 나타낸다. 하나는 다른 모듈의 클래스를 수퍼 클래스로 사용 할 때 영향을 고려 했다는 것이고, 다른 하나는 그에 따라 적절하게 클래스를 디자인 했다는 것이다.

//: #### 제어 수준에 대한 원칙 (Guiding Principle of Access Levels)
// 전반적으로 다음 규칙을 따른다.
// - 어떤것도 그것보다 낮은 제어 수준을 가진것으로 정의 될 수 없다.
// Access levels in Swift follow an overall guiding principle: No entity can be defined in terms of another entity that has a lower (more restrictive) access level.
// 예를 들어
// * internal, file-private, private 타입의 객체는 public 변수가 될 수 없습니다. 왜냐하면 해당 타입은 public 변수가 사용되는 모든 곳에서 사용 가능 하지 않을 수 있기 때문이다. (A public variable can’t be defined as having an internal, file-private, or private type, because the type might not be available everywhere that the public variable is used.)
// * 함수는 그것보다 높은 제어 수준을 갖는 파라미터나 리턴 타입을 가질 수 없습니다. 왜냐하면 그 함수가 둘러쌓인 환경에서 파라미터의 타입이나 리턴 타입에 접근 하지 못할 수 있기 때문입니다.(A function can’t have a higher access level than its parameter types and return type, because the function could be used in situations where its constituent types are unavailable to the surrounding code.)


// Swift 언어의 여러 다른 측면에서 이 규칙이 가진 의미에 대해서 계속해서 알아보겠습니다.

//: ## 기본 접근 레벨(Default Access Level)
// 몇 가지 특수한 경우를 제외하곤, 명시적으로 다른 제어 수준을 선언하지 않으면 모든 코드는 internal 이다.

//: ## 단일 타겟의 접근 수준(Access Levels for Single-Target Apps)
// 만약 단일 타겟 앱을 만든다면 다른 외부 모듈에서 접근을 허용 할 필요가 없을 것입니다. 기본 접근 레벨이 internal 인 것은 이 요구사항에 부합 합니다. 따라서, 기본적으로는 접근 수준을 선언 할 필요가 없습니다. 한편 한 모듈 안이지만 fileprivate, private 을 이용해서 접근을 제한 하길 원할 수 있고 해도 됩니다.

//: ## 프레임워크의 제어 수준(Access Levels for Frameworks)
// 만약 프레임워크를 개발한다면 공개 해야 할 부분은 open , public 을 이용해서 표시 할 수 있습니다. 이런 공개된 부분이 프레임워크의 API 입니다.

//: ## 유닛 테스트 타겟의 제어 수준(Access Levels for Unit Test Targets)
// open 이나 public 으로 된 객체만 다른 모듈에서 접근 가능하다. 그러나 유닛 테스트에서는 어떤 내부 모듈도 접근 가능하다. import 구문 앞에 @testable 을 명시하고, 유닛 테스트 모듈을 "Test enabled" 로 설정 한다음 컴파일하면 된다.
// ex) @testable import MyApp

//: ## 커스텀 타입
// 타입의 접근 레벨은 멤버(프러퍼티, 메소드, 첨자 연산자, 생성자)들에게 그대로 적용된다. 어떤 타입을 private 이나 fileprivate 으로 설정하면 멤버들의 기본 접근 레벨도 private 이나 fileprivate 이다.
// internal(묵시적 선언 포함) 이나 public 으로 설정한 타입의 멤버는 internal 로 설정된다.
// * 주의 점은 public 으로 선언된 타입의 멤버가 public 이 아니라 internal 이라는 것이다. 만약 특정 멤버를 public 으로 하고 싶으면, 명시적으로 public 으로 선언해야 한다.

public class SomePublicClass {                  // explicitly public class
    public var somePublicProperty = 0            // explicitly public class member
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

class SomeInternalClass {                       // implicitly internal class
    var someInternalProperty = 0                 // implicitly internal class member
    fileprivate func someFilePrivateMethod() {}  // explicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

fileprivate class SomeFilePrivateClass {        // explicitly file-private class
    func someFilePrivateMethod() {}              // implicitly file-private class member
    private func somePrivateMethod() {}          // explicitly private class member
}

private class SomePrivateClass {                // explicitly private class
    func somePrivateMethod() {}                  // implicitly private class member
}

//: ## 튜플 타입
// 튜플은 이루고 있는 타입들 중 가장 폐쇄적인 접근 제어 수준으로 선언된다. 예를 들어 (internal, private) 으로 구성된 튜플이라면 private 이 된다.
// 튜플의 접근 수준은 명시적으로 선언될 수 없고, 해당 조합에 의해 자동으로 설정된다.

//: ## 함수 타입
// 함수는 함수를 구성하는 파라미터 타입과 리턴 타입들 중 가장 폐쇄적인 수준으로 결정된다. 만약 이 결과가 문맥상 맞지 않다면 접근 수준을 명시적으로 선언해줘야 한다.
// 아래 예보면, 묵시적인 기본 수준은 internal 이니 someFunction 은 internal이다. 하지만 리턴값이  internal, private 로 이루어진 튜플이기 때문에 가장 폐쇄적인 private 이 접근 레벨이다. 묵시적인 것과 계산된 수준이 다르기 때문에 오류가 발생한다. 따라서, private 을 명시적으로 선언해줘야 한다.
private func someFunction() -> (SomeInternalClass, SomePrivateClass) {
    return (SomeInternalClass.init(), SomePrivateClass.init())
}
// 위 예제의 someFunction 선언 앞에 private 을 지워보자. 그리고 그 에러 메시지를 보길 바랍니다.

//: # 열거형 타입
// 열거형은 멤버들 각각의 접근 수준을 선언 할 수 없고, 타입에 선언된 수준을 따라간다.

//: ## Raw Values, 연관 타입
// 열거형의 Raw Values나 연관 타입은 열거형 타입의 접근 수준과 같거나 더 개방적이어야 한다. 예를들어, internal 열거형 타입은 private Raw Value를 가질 수 없다.

//: ## 내포 타입(Nested type)
// 1. private 안에 선언된 내포 타입의 기본 접근 레벨은 private 이다.
// 2. fileprivate 안에 선언된 내포 타입의 기본 접근 레벨은 fileprivate 이다.
// 3. public 이나 internal 로 선언된 타입의 내포 타입은 internal 이 기본 접근 수준이 된다.
//    만약 public 으로 선언된 타입의 내포 타입을 public 으로 선언하고 싶으면, 명시적으로 public 을 적어야 한다.

//: # 상속(Subclassing)
// 연재 문맥속에 있는 어떤 것이든 상속이 가능합니다. 또한, 수퍼 클래스보다 서브 클래스가 높은 개방도를 갖게 할 수 없습니다. 예를들어 수퍼 클래스가 internal 인데 자식 클래스가 public 일 수 없습니다.
// 접근 가능한 멤버들은 모두 오버라이드 가능합니다. 이때는, 폐쇄적인 접근 레벨에서 더 개방적인 접근 레벨로 바꿀 수 있스니다.
// 예제
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {}
}

// 만약, 수퍼 클래스의 멤버가 접근이 허락된 문맥상에 존재한다면, 서브 클래스의 멤버보다 낮은 접근 수준의 수퍼 클래스의 멤버를 호출하는 것은 유효합니다.
// 예를 들어, 같은 파일에 있는 fileprivate 수퍼 클래스의 멤버를 호출하거나, internal 인 수퍼 클래스를 같은 모듈 안에서 호출하는 것이 가능합니다.
// 예제 - 아래 클래스들은 같은 파일에 구현되어 있습니다.
// AA 의 fileprivate 메소드인 someMethod는, AA의 서브클래스 BB 에서 internal 로 개방도가 높아졌고, 또한 유효한 문맥상에 있으므로 수퍼 클래스의 someMethod도 호출 가능합니다.
public class AA {
    fileprivate func someMethod() {}
}

internal class BB: AA {
    override internal func someMethod() {
        super.someMethod()
    }
}

//: # 상수, 변수, 프로퍼티, 첨자 연산자
// 상수, 변수, 프로퍼티는 그 자신의 타입보다 더 개방적인 수준이 될 수 없습니다. 예를들어 private 타입에 public 멤버가 있을 수 없습니다. 유사하게 첨자 연산자는 그것의 인덱스 타입이나 반환 타입보다 더 개방도가 높은 수준으로 선언 될 수 없습니다.
// 만약 상수, 변수, 프로퍼티, 첨자 연산자가 private 타입으로 사용된다면, private 을 꼭 적어줘야 합니다.
private var privateInstance = SomePrivateClass() // 이 예제에서 private 을 빼면 어떤 에러가 나는지 확인하세요.

//: ## Getter, Setter
// 상수, 변수, 프로퍼티, 첨자 연산자의 getter 와 setter 는 자동으로 이들의 접근 수준과 같게 됩니다.
// setter 는 그것과 대응하는 getter 보다 낮은 수준의 접근 수준으로 설정 할 수 있습니다. 그것들의 읽기-쓰기 범위를 제한하기 위해서죠. 
// fileprivate(set), private(set), internal(set) 같은 방식으로 사용하면 됩니다.
// 이 규칙은 저장형 프로퍼티와 계산형 프로퍼티 모두 동일하게 적용 됩니다.

// 예제
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}
// 위의 경우 numberOfEidts 의 getter 는 internal 이고, setter 는 private 이 됩니다.
var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")
// Prints "The number of edits is 3"

// 아래 예제처럼 setter 와 getter 의 접근 수준을 명시적으로 표시 할 수 있습니다.
public struct OtherTrackedString {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

//: # 생성자
// 생성자는 속한 타입의 접근 수준과 같거나 낮은 수준으로 할당 될 수 있습니다.
// 한가지 예외는 required 생성자입니다. required 생성자는 생성자가 속한 타입과 같은 접근 수준이 되어야 합니다.
// 생성자의 파라미터 접근 수준은 생성자의 접근 수준보다 더 폐쇄적일 수 없습니다.

//: ## 기본 생성자
// 기본 생성자는 속한 타입이 public 으로 되어있지 않는 한, 타입과 같은 접근 수준을 갖습니다.
// public 으로 선언된 타입의 기본 생성자는 internal 로 간주됩니다.
// 만약 public 타입이 다른 모듈에서 파라미터가 없는 생성자로 생성될 수 있기를 원한다면, 명시적으로 public 한 파라미터 없는 생성자를 선언해줘야 합니다.

//: ## 구조체의 멤버 변수명 기본 생성자(memberwise initializer)
// 만약 구제체의 멤버 중 어떠한 것이라도 private 이 있으면, 멤버 변수명 기본 생성자의 접근 수준은 private 이 됩니다.
// 비슷하게 멤버 변수 중 fileprivate 이 있으면, 멤버 변수명 기본 생성자는 fileprivate 이 됩니다.

// 이런 규칙에 의해 다른 모듈에서 멤버 변수명 기본 생성자를 이용 할 수 있게 하려면 해당 구현을 직접 제공해야 합니다.

//: # 프로토콜
// 프로토콜도 명시적으로 접근 수준을 선언 할 수 있습니다.
// 프로토콜에 정의된 것들은 자동으로 프로토콜 자신의 타입과 같은 접근 수준을 갖습니다.
// 프로토콜에서 지원하는 접근 수준과 다르게 프로토콜의 요구 사항을 지정 할 수 없습니다.
// 이렇게 하면 프로토콜을 채택(adopts)한 어떤 타입에서라도 해당 프로토콜의 모든 요구사항(프로퍼티, 메소드 등)을 접근 할 수 있습니다.
// * public 프로토콜을 선언하면, public 으로 구현해야 합니다. 이것이 다른 타입들과 다른 부분입니다. public 타입으로 지정되면 멤버들이 internal 로 되는 것과 비교됩니다.

//: ## 프로토콜 상속
// 상속 받은 프로토콜은 부모 프로토콜보다 더 높은 수준의 개방성을 가질 수 없습니다. 예를 들어 internal 로 선언된 프로토콜을 상속 할 때 public 으로 할 수 없습니다. 더 폐쇄적인 수준으로는 가능합니다.

//: ## 프로토콜 확인(conform)
// 어떤 타입이라도 해당 타입보다 낮은 접근 수준을 가진 프로토콜을 채택 했는지 확인 할 수 있습니다. 예를 들어, 다른 모듈에서 사용 할 수 있는 public 타입을 선언하고, internal 프로토콜을 구현 했습니다. 그러면 internal 프로토콜 이 채택되었는지 확인하는 것은 그 프로토콜이 선언된 모듈 내에서만 확인이 가능합니다. 왜냐하면 internal 프로토콜이 다른 모듈에선 보이지 않으니까요.
// 어떤 특정한 프로토콜을 확인하는 타입은 그 타입의 접근 수준과 프로토콜의 접근 수준 중 가장 폐쇄적인 접근 수준이 된다. 만약 타입이 public 인데 채택한 프로토콜이 internal 이면, 그 프로토콜에 대한 타입 확인 역시 internal 입니다.
// (The context in which a type conforms to a particular protocol is the minimum of the type’s access level and the protocol’s access level. If a type is public, but a protocol it conforms to is internal, the type’s conformance to that protocol is also internal.)
// 어떤 타입을 새로 작성하거나 확장하기 위해 프로토콜을 채택 할 때, 프로토콜의 각각의 요구 사항의 구현은 채택하고 있는 프로토콜과 접근 수준이 최소한 같은 접근 수준이어야 한다. 예를 들어, public 타입이 internal 프로토콜을 채택하면, 프로토콜의 각 요구 사항에 대한 그 타입의 구현이 최소한 internal 수준은 되어야 한다.
// 스위프트와 Objective-C 의 프로토콜 채택은 전역적이다. 즉, 한 프로그램 내에서 어떤 타입이 한가지 프로토콜을 두개 이상의 다른 방식으로 구현 할 수 없습니다.

//: # Extensions
// 익스텐션을 통해 추가된 멤버들은 기본적으로 해당 타입의 접근 수준을 갖습니다. 만약 확장을 통해 public 이나 internal 타입에 멤버가 추가되면, 추가된 멤버들은 기본적으로 internal 이 됩니다.
// 만약 fileprivate 타입을 확장하면 새로운 멤버의 기본 접근 수준은 fileprivate 이 됩니다. private 타입을 확장하면 새로운 멤버는 private 입니다.
// 한편 명시적으로 접근 수준을 선언 할 수 있습니다. 그러면 새로운 멤버는 모두 명시적으로 선언한 제어 수준을 갖게 됩니다. "private extension" 처럼요. 이때도 개별 멤버에 대해 명시적으로 다른 접근 수준을 선언 할 수 있습니다.
// 만약 프로토콜을 채택하는데 익스텐션을 사용한다면 명시적으로 접근 수준을 선언 할 수 없습니다. 
// 예 ) private extension SomeClass : SomeProtocol 은 안된다는 거죠.
// 반대로, 익스텐션 안에서 프로토콜 자신의 접근 수준은 개별 멤버의 기본 접근 수준을 명세하기 위해 사용 됩니다.

//: ## Private member in extensions
// 어떤 타입이 구현된 파일 내에 익스텐션이 있다면, 그것은 마치 그 타입의 일부인 것처럼 동작 할 것입니다.즉, 외부에서 보기에 extension 으로 나뉘어진 것인지 아닌지 알 수 없습니다.
/**
 * 원래 타입에서 private 멤버를 선언하고 같은 파일의 익스텐션에서 해당 멤버에 접근 가능합니다.
 * 하나의 익스텐션에서 private 멤버를 선언하고 같은 파일의 다른 익스텐션에서 접근 가능합니다.
 * 익스텐션에서 private 멤버를 선언하고, 같은 파일의 타입의 원본 부분에서 새로 추가된 멤버를 접근 가능합니다.
 */
// 예제)
protocol SomeProtocol {
    func doSomething()
}

struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSomething() {
        print(privateVariable)
    }
}

//: # Generics
// 제너릭 타입이나 함수의 접근 레벨은 자신, 그리고 그와 관련된 파라미터, 상수의 접근 레벨의 최소치와 같습니다.

//: # Typealias
// Typealias 는 원본과 다른 타입으로 취급 됩니다. 따라서 원본과 같거나 더 폐쇄적인 접근 상태로 선언 가능합니다.

public class SomePrivateType { }
private typealias NewSomePrivateType =  SomePrivateType

// 이 규칙은 프로토콜 구현을 위해 연관 타입에도 적용됩니다.

//: [Next](@next)
