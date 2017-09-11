//: [Previous](@previous)

import Foundation

//: ## Protocol

// 프로토콜은 특정 사안이나 기능에 적합한 메소드, 프로퍼티, 요구사항의 청사진이다.
// 클래스, 구조체, 열거형은 이 기능들을 구현하기 위해서 프로토콜을 채택(adopt) 할 수 있다.
// 어떤 타입이든 이 프로토콜의 요구사항을 만족 시키는 것은 프로토콜을 따르고 있다(conform)고 한다.

//: #### Syntax
// 프로토콜 선언
// protocol SomeProtocol { ... protocol definition goes here ...}

// 구조체에서 프로토콜을 채택할 때는 구조체 이름 뒤에 : 을 쓰고 프로토콜을 나열하면 된다. 여러 프로토콜을 채택 할 때는 , 로 구분한다.
//  struct SomeStructure: FirstProtocol, AnotherProtocol {
//   structure definition goes here
//  }


// 클래스가 프로토콜을 채택 할 때는 수퍼 클래스를 가장 앞에 쓰고 뒤에 프로토콜을 나열한다.
//class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
//    // class definition goes here
//}

//: #### 프로퍼티 정의
// 프로퍼티가 getter 나 setter 를 갖도록 정의하지만, 저장형 프로퍼티인지 계산형 프로퍼티인지는 정의하지 않는다.
// 해당 부분은 구현하는 곳에서 책임진다.
// 또한 프로토콜에서 getter 만 정의 했을 때, setter 를 정의해도 문법에 위반되지 않는다. 필요하면 구현 가능하다.


//: ### 예제
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
// ncc1701.fullName is "USS Enterprise"
print("ncc1701.fullName is \(ncc1701.fullName)")

//: ### 메소드 요구사항
// 프로토콜에서 정의한 메소드는 파라미터에 기본값을 지정 할 수 없다.
// 타입 메소드는 static 키워드를 붙인다.

//: #### 예제

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.37464991998171"
print("And another one: \(generator.random())")
// Prints "And another one: 0.729023776863283"

//: ### 변경(Mutating) 가능한 메소드 요구사항
// 값 타입의 인스턴스는 자신의 프로퍼티를 수정하는 메소드에 mutating 한정자를 붙인다는 것을 기억할 것이다.
// 마찬가지로, protocol 에서도 자신의 프로퍼티를 수정할 메소드를 선언할 때는 mutating 을 붙여준다.
// 클래스 타입은 mutating 키워드가 필요 없으므로, 프로토콜을 구현 할 때도 마찬가지로 필요 없다.

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()


//: ### 생성자
protocol InitExamProtocol {
    init(someParameter: Int)
}

//: #### 프로토콜의 생성자를 "클래스"에서 구현 할 때
// 프로토콜에서 요구하는 생성자의 구현은 편의 생성자 또는 지정 생성자 모두 가능하다.
// 단, 이 경우 꼭 "required" 한정자를 붙여야 한다.
class InitExamClass: InitExamProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}

// final class 일 때는 required 를 붙일 필요 없다. 왜냐하면 override 될 일이 없으니까.

protocol InitProtocol {
    init()
}

class InitSuperClass {
    init() {
        
    }
}
class InitExamSubClass: InitSuperClass , InitProtocol {
    // "required" from InitProtocol conformance; "override" from InitSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

//: #### 실패 가능한 생성자
// 프로토콜에서도 실패 가능한 생성자를 선언 가능하다.

//: ### 타입으로써 Protocol
/*:
 * 프로토콜을 파라미터, 리턴 타입으로 이용 가능
 * 상수, 변수, 프로퍼티의 타입으로써 프로토콜 사용 가능
 * 배열, 딕셔너리 같은 컨테이너의 타입으로써 사용 가능
 */

// 예제
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


//: ### Delegation 위임
// 위임은 어떤 클래스나 구조체의 일정 기능을 다른 타입의 인스턴스에 넘기는 디자인 패턴이다.
// 위임 디자인 패턴은 위임될 책임들을(기능) 프로토콜로 정의하는 것이다.

// 예제
protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


//: ### 익스텐션과 프로토콜의 조합
// 이렇게 하면 해당 타입과 구현하는 프로토콜이 한군데 뭉쳐 있어서 가독성이 증가 된다.
// 또한, 프로토콜 또한 타입이라고 했으므로, 프로토콜을 구현한 타입의 타입 확장 효과도 갖게 된다.

protocol TextRepresentable {
    var textualDescription: String { get }
}
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)
// Prints "A 12-sided dice"

extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)
// Prints "A game of Snakes and Ladders with 25 squares"

//: #### 미리 구현된 타입에 나중에 프로토콜 선언하기
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
// Hamster 는 TexRepresentable 을 채택 하기 전에 이미 같은 형태의 메소드를 구현했다. 그렇다면 추가적으로 구현할 필요 없이 프로토콜을 채택했다는 표식만 붙여줌으로써 타입 이름 추가 효과를 줄 수 있다.
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)
// Prints "A hamster named Simon"

//: #### 프로토콜 타입 집합
// 거두절미하고 예제를 보자
let things: [TextRepresentable] = [game, d12, simonTheHamster]
// things 의 구성요소 game, d12, simonTheHamster 가 모두 TextRepresentable 을 채택하고 있으니 위와 같이 집합으로 구성 가능하고, 아래와 같이 TextRepresentable 의 메소드를 호출 할 수 있다.
for thing in things {
    print(thing.textualDescription)
}

//: ### 프로토콜 상속
// 여러 프로토콜을 조합해서 하위 프로토콜을 선언 할 수 있다.
protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}
print(game.prettyTextualDescription)
// A game of Snakes and Ladders with 25 squares:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○

//: ### 클래스 전용 프로토콜
// 프로토콜 상속 할 때 AnyObject 를 명시하여 클래스 전용 프로토콜이라 선언 할 수 있다.
// 선언하려는 프로토콜의 특성이 값 타입이 아니라 참조 타입일 때 이런 제약을 이용하는 것이 좋다.

protocol SomeClassOnlyProtocol: AnyObject, SomeProtocol {
    // class-only protocol definition goes here
}


//: ### 프로토콜 조합
// 한번에 여러 프로토콜을 채택 할 수 있다.
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct ComposedPerson: Named, Aged {
    var name: String
    var age: Int
}
// 파라미터로 Named, Aged 두개의 프로토콜을 채택한 인스턴스를 받는다.
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = ComposedPerson(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)


// 아래 예제의 beginConcert 는 클래스와 프로토콜을 동시에 만족하는 구문을 이용하는데, 이것은 swift 4.0 부터 지원한다.
/*
class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)
*/

//: ### 프로토콜 채택 여부 확인하기
/*:
 오퍼레이터
 * is : 인스턴스가 프로토콜을 채택 했으면 true, 아니면 false
 * as? : 인스턴스를 다운 캐스트 하는 연산자. 프로토콜을 채택하지 않았으면 nil 을 반환
 * as! : 인스턴스를 다운 캐스트 하는 연산자. 프로토콜을 채택하지 않아서 다운 캐스팅에 실패하면 런타임 에러 발생
*/

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
// 3개의 인스턴스가 HasArea를 채택했는지 확인하는 예제
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

//: #### Optional Protocol 
// 프로토콜에 정의 된 것은 모두 구현해야 하지만, optional 키워드로 수식한 것은 구현을 안해도 된다.
// 또한, @objc 키워드와 함께 사용한다. 프로토콜 선언시에도 사용하고, 메소드, 프로퍼티 앞에도 사용한다.

// * @objc 키워드는 swift - objective-c 연동을 위해서 사용하는 키워드인데, 클래스만 사용 가능하다.
// 열거형 구조체는 불가능. 또한 Objective-C 클래스이거나 @objc 키워드를 사용한 다른 클래스만 가능하다.

// optional 한정자를 이용하면 함수 전체가 자동으로 옵셔널로 감싸지게 된다.
// 예를 들어, optional (Int) -> Int 은 ((Int) -> Int)? 가 된다. 리턴 값이 옵셔널이 되는게 아니라 전체가 옵셔널이다.
// 또한 일반적인 optional chaining 을 할 수 있다.

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

print("--- ThreeSource")
class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

print("--- TowardsZeroSource ")
class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}


//: ## Protocol Extensions
// 프로토콜도 extension 이용 할 수 있다. 그러면 기본 구현이 만들어지게 되고, 프로토콜을 채택하는 타입마다 구현 할 필요 없이 기본 구현이 제공된다. 물론, 그렇다해도 해당 타입에서 해당 부분을 구현할 수 있다.

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

let otherGenerator = LinearCongruentialGenerator()
print("Here's a random number: \(otherGenerator.random())")
// Prints "Here's a random number: 0.37464991998171"
print("And here's a random Boolean: \(otherGenerator.randomBool())")
// Prints "And here's a random Boolean: true"

extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}


//: ### Protocol Extension 에 제약사항 가하기
// 프로토콜을 채택하기 전에(구현하기 전에) 특정한 제약사항을 만족시켜야 한다고 강제 할 수 있다.
// 프로토콜 확장 다음에 where 절을 추가한다. where 절에 관해서는 23_Generics 를 참조하시라.
// * 연관 타입 (associated type)

//: ##### Syntax : extension 확장할프로토콜 where Generic조건 : 채택할프로토콜

// 예제)
// Collection 프로토콜을 확장 했으며, where 절의 Iterator.Element 는 해당 객체가 어떤 타입인지 드러내 준다.
extension Collection where Iterator.Element : TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let murrayTheHamster = Hamster(name: "Murray")
let morganTheHamster = Hamster(name: "Morgan")
let mauriceTheHamster = Hamster(name: "Maurice")
let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]

print(hamsters.textualDescription)

// ❊ 만약 여러가지 제약사항이 걸려있고, 계층상 중복되는 것이 있다면 가장 명확하게(가장 하위) 선언된 조건을 이용할 것이다.
//: [Next](@next)
