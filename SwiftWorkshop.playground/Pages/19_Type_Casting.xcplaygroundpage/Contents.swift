//: [Previous](@previous)

import Foundation

//: ## Type Casting

// 타입 캐스팅은 인스턴스의 타입이 특정 클래스인지, 수퍼 클래스인지, 서브 클래스인지 체크하는 것이다.
// "is" 와  "as" 두가지 함수를 이용한다.

//: ### 타입 캐스팅을 위한 계층도 만들기 예제
// Movie, Song 은 MediaItem 의 서브 클래스이다.

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

//: #### 타입 체크 해보기 예제
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

var movieCount = 0
var songCount = 0

// is 함수를 이용해서 타입 체크를 했다.
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")

//: ## Downcasting

// 어떤 클래스의 인스턴스가 해당 클래스 계층에 있는 서브 클래스 일 수 있다. as? 나 as! 를 이용해서 그 인스턴스를 그 인스턴스의 실제 subclass 타입으로 지칭 할 수 있다.
// 다운캐스팅은 실패 할 수 있기 때문에, as? 나 as! 두 가지고 나뉘어진다. 다른 것과 마찬가지로 as?는 실패 시 nil 을 반환하며 as! 는 런타임 에러를 발생한다.

// 예제
for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

// 다운캐스팅이 실제로 인스턴스를 변경시키지는 않는다. 다만, 타입을 명확히 하여 해당 타입에 맞는 프로퍼티, 메소드를 사용 할 수 있게 해줄 뿐이다.

//: ## Any와  AnyObject 타입
//: #### Any 는 어떤 타입이든 가능. 함수 타입도 포함
//: #### AnyObject 는 클래스 타입만

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
things.append({ (name: String) -> String in "Hello, \(name)" })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

//: [Next](@next)
