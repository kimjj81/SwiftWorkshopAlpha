//: [Previous](@previous)

import Foundation

//: ARC(Automatic Reference Counting) 에 의해 소멸될 때 생성되는 것. 클래스 타입에만 가능.

// 인스턴스에 할당 된 모든 자원 해제하는 역할. 자동으로 대부분의 자원을 해제하므로 일반적으로는 구현 할 필요가 없다.
// 단, 파일을 열었으니 닫아야 할 경우, 클래스가 소멸되기 전에 저장하는 경우 등 특수한 상황에서 활용 될 수 있다.

// Syntax
// : deinit { }

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}
class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        print ("deinit called")
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"


playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// Prints "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// Prints "The bank now only has 7900 coins left"

playerOne = nil
print("PlayerOne has left the game")
// Prints "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// Prints "The bank now has 10000 coins"


// ❊ 덧붙이자면 deinit 은 명시적으로 소멸 타이밍을 설정하기 어려우므로,
// MVC 사이클에서 view 생성, 등장, 사라짐에 따라서 uninitialized, activated, suspended, finished 같은 자신만의 명시적인 상태를 정의해서 자원 관리, Notification 관리 등등을 관리하는게 좋다.



//: [Next](@next)
