//: [Previous](@previous)

import Foundation

//: ## Generics (이하 제너릭이라 칭함)

// 제너릭을 이용하면 코드 중복을 줄이고, 추상화된 표현으로 의도를 명확하게 할 수 있다.
// Swift 에서 가장 강력한 부분이고, 눈치채지 못했을지도 모르지만 Array, Collection 모두 제너릭을 활용했다.

//: #### 제너릭으로 해결 가능한 문제

// 예) 제너릭하지 않은 구문

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
// 만약 String, Double 을 바꾸는 함수가 필요하면 해당 타입에 대응되는 함수를 여럿 만들어야 할 것이다.

//: #### 제너릭 선언
// Syntax : < > 괄호 안에 원하는 문자를 넣고, 해당 문자를 타입처럼 사용하면 된다.
// 아래 예제에서는 Type 의 T를 썼다. (C++에서는 Template)
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
// 타입별로 함수를 만들었던 것에 반해, 위 함수처럼 제너릭을 활용하면 밑의 예제처럼 Int, String 등 다양한 타입에 쓸 수 있다.
var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)


//: #### 파라미터 타입 이름 짓기
// 의미 있는 이름을 짓는게 원칙이다. 예를 들어, Array<Element>, Dictionary<Key,Value> 처럼 한다. 그러나 딱히 그런 것을 찾을 수 없으면 전통적으로 쓰는 T,U,V 같은 걸 쓴다. 또한 타입이라 명시해주기 위해 첫글자는 대문자를 사용한다.

//: ### Generic Types

// 지금까지는 제너릭 함수를 보았고, 제너릭 타입에 대해 알아보자.

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")

extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

stackOfStrings.topItem

//: ### 제너릭 타입에 제약 사항 두기
// 제너릭 타입이 특정 클래스나 프로토콜임을 선언하는게 필요 할 때가 있다. 가령 Dictionary 의 Value는 어떤 것이라도 될 수 있지만 Key 는 Hashable 이어야 한다.

// Syntax
//  func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//      // function body goes here
//  }

// 예제
// 기존 방식
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

//: #### 제너릭 이용하기

// 만약 아래 처럼 펑션을 선언한다면 두 인스턴스간에 == 오퍼레이터가 정의되지 않아서 오류가 난다.
// func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
// 때문에 == 오퍼레이터가 정의되어있다는 것을 확신시켜 주기 위해서 Equatable 을 제너릭에 수식해준다.
func findIndex<T : Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2



//: ### 연관 타입 (Associated Types)

// 프로토콜을 정의 할 때, 유용하게 쓰일 수 있는 연관 타입을 선언 할 수 있습니다. 하나 이상 선언 가능합니다.
// 프로토콜의 일부로 사용되는 특정 타입에 대해 플레이스 홀더 이름을 부여 하는 기능입니다.
// Placeholder : 어떤 집합의 임의의 원소의 명칭으로 바꾸어 놓을 수 있는 수식[논리식] 내의 기호.
// 즉, 실제 타입은 프로토콜이 구현 되기 전까지 확정되지 않습니다. 
// associatedtype 키워드를 이용하여 선언합니다.

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

// 위 구문을 분석해보면,
// - 컨테이너에 append 메소드를 이용해서 새로운 아이템을 추가 가능합니다.
// - count 프로퍼티를 통해 몇개의 아이템이 있는지 알 수 있습니다.
// - Int 파라미터를 사용하는 첨자연산자([])를 통해 ([인덱스]) 아이템에 접근 할 수 있어야 합니다.

// 위 프로토콜은 어떤 타입을 품을 지 확정하지 않았습니다. 다만 타입을 어떻게 부를 것인지 Item 이라는 플레이스홀더를 만들어 두었을 뿐입니다.
// 하지만, 이 프로토콜에 저장되는건 특정한 타입만 되어야 합니다.
// 그래서 아래와 같은 예제가 만들어 졌습니다.

// typealias 를 통해 Item 이 Int 라고 확정했습니다. 그래서 Item 이라는 플레이스 홀더를 모두 Int 로 바꿀 수 있었습니다.
struct IntStack: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
// 그런데 위 예제에서 typealias Item = Int 부분은 생략해도 됩니다. 왜냐면 프로토콜의 구현 부분에서 모두 Int 를 사용했으므로 Swift 의 추론 시스템이 Item = Int 라고 알아 낼 수 있기 때문입니다.

//: ##### 제너릭 이용하기
struct GenericStack<Element>: Container {
    // original Stack<Element> implementation
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
// 이것도 마찬가지로 추론 시스템이 활용되었습니다.

//: ### 기존에 존재하는 타입을 특정한 연관 타입으로 확정하기
// Array 는 이미 본 장에서 작성한 Container 프로토콜의 메소드를 다 구현하고 있다. 따라서 Array 가 Container 타입이기도 하다는 것을 명시하기 위해 다음과 같이 쓸 수 있다.
extension Array: Container {}

//: 연관 타입에 제약 사항을 두기 위해 타입 어노테이션 이용하기
// 예제
protocol AssociatedContainer {
    associatedtype Item: Equatable // 주목할 부분. Item 은 Equatable 을 구현한 것이어야 한다.
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//: ## 제너릭 where 절
// 연관 타입에 요구사항을 정의 하는건 유용 할 때가 있다. 이런 경우 generic where 절을 이용 할 수 있다.
// generic where 절은 연관 타입이 특정 프로토콜을 따르고 있는지 체크한다. 또는 파라미터에 대해서도 체크 할 수 있다.
// Syntax : { 가 시작되기 직전에 where 절을 삽입한다.

// 예제
func allItemsMatch<C1: Container, C2: Container>
    (_ someContainer: C1, _ anotherContainer: C2) -> Bool
    where C1.Item == C2.Item, C1.Item: Equatable {
        
        // Check that both containers contain the same number of items.
        if someContainer.count != anotherContainer.count {
            return false
        }
        
        // Check each pair of items to see if they're equivalent.
        for i in 0..<someContainer.count {
            if someContainer[i] != anotherContainer[i] {
                return false
            }
        }
        
        // All items match, so return true.
        return true
}

// allItemsMatch 함수를 이용하기 위해서는 위 조건을 만족하는 파라미터를 이용해야 한다.

// 위 예제의 조건을 다시 풀어쓰면
/*
 * C1 은 Container 프로토콜을 채택해야 한다(conform) ( C1: Container 이라 적혀있다 ).
 * C2 역시 Container 프로토콜을 채택해야 한다. (C2: Container ).
 * C1의 Item 은 C2의 Item 과 같아야 한다. ( C1.Item == C2.Item ).
 * C1 은 Equatable 프로토콜을 채택해야 한다.( C1.Item: Equatable ).
 */

var genericStackOfStrings = GenericStack<String>()
genericStackOfStrings.push("uno")
genericStackOfStrings.push("dos")
genericStackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(genericStackOfStrings, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}

//: ## Extension 과 제너릭 where 절

// Extension 에도 제약 사항을 두기 위해 where 를 쓸 수 있다.
// 아래 예제는 GenericStack 의 아이템이 Equatable 을 채택하도록 명시했다.
// 이 예제에서 where 구문을 빼면 item 이 == 오퍼레이션이 없다고 여겨 지므로 컴파일 에러가 발생한다.
extension GenericStack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if genericStackOfStrings.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

struct NotEquatable { }
var notEquatableStack = GenericStack<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
// 아래 주석을 해제해보면 에러가 발생하며, 왜 그런지 알 수 있다.
//notEquatableStack.isTop(notEquatableValue)  // Error

//: #### 프로토콜 extension 에 where 사용하기
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}
if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}
// Prints "Starts with something else."

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
// 아래 배열에 다른 형을 입력해보자. 에러가 발생 한다.
print([1260.0, 1200.0, 98.6, 37.0].average())

//: #### 연관 타입에 제너릭 where 절 사용하기 (Swift 4.0 부터 지원)

// 문법 : associatedtype Item  where ....
//protocol OtherContainer {
//    associatedtype Item where Item == Int
//    mutating func append(_ item: Item)
//    var count: Int { get }
//    subscript(i: Int) -> Item { get }
//    
//    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
//    func makeIterator() -> Iterator
//}

//: #### 제너릭 Subscripts (Swift 4.0 부터)

//extension Container {
//    subscript<Indices: Sequence>(indices: Indices) -> [Item]
//    where Indices.Iterator.Element == Int {
//      var result = [Item]()
//      for index in indices {
//          result.append(self[index])
//      }
//      return result
//    }
//}

// 위 Container 의 Extension 은 특정 인덱스들을 포함한 아이템들을 반환합니다.
/* 제너릭 Indices 형 파라미터인 indices 는 Sequence 프로토콜을 채용(conform) 하고 있음을 나타냅니다. <Indices : Sequence> 부분
 * Subscript 는 indeices 파라미터를 하나 받습니다.
 * 그 다음줄인 generic where 줄은 Indices의 Iterator 연관타입이 Int 임을 명시합니다.
 *  이것을 합하면 이 재약사항들은 인자로 넘겨진 인덱스들 파라미터는 정수형 Sequence라고 결론 내릴 수 있습니다.
*/

//: [Next](@next)
