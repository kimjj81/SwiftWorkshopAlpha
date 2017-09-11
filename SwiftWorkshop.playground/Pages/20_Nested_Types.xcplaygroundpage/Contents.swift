//: [Previous](@previous)

import Foundation

//: ## Nested Types (내포 타입)
// 열거형은 가끔 특정 타입만을 위해서 쓰일 때가 종종 있다. 이와 비슷하게 편의를 위해 특정 맥락에서만 쓰일 클래스나 구조체를 만드는 경우도 있다. 이를 위해서 어떤 타입 정의 안에 구조체, 클래스, 열거형을 포함 하여 정의 할 수 있다.
// 내포 타입은 타입 정의 중괄호 안에 넣으면 되고, 원하는 깊이 만큼 얼마든 중첩 시킬 수 있다.

struct BlackjackCard {
    
    // nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    // nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        
        struct Values {
            let first: Int, second: Int?
        }
        
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}
// 위 예제에서 BlackjackCard 에 " Suit, Rank " 2개의 열거형이 내포 되어 있고, Rank 에는 " Values " 가 내포되어 있다.
// BlackjackCard - enum Suit
//               - enum Rank
//                          - enum Values

// 예제
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// 위 예제에서 BlackjackCard 는 init 이 없으므로, 자동으로 memberwise init 이 생성되었고, 해당 멤버들은 클래스 선언에 정의되어 있으므로 타입 추론이 가능하기 때문에 앞에 타입은 생략하고 . 이후에 값을 적을 수 있다.

// 내포된 값들 참조하기 예제
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print("\(heartsSymbol) is \"♡\"")


//: [Next](@next)
