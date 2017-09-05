//: Function - 
// 특정한 작업을 수행하는 코드 덩어리. Function은 파라미터 타입과 리턴 타입을 가진다.
// Function 또한 타입이라 파리미터, 리턴 값으로 사용 가능함.
// 파라미터는 상수임.

// 선언 : func funcname(argumentLabel parameterName:Type,) -> Type { }
func factorial(n:Int) -> Int {
    if(n == 0 || n == 1) {
        return 1
    }
    else {
        return factorial(n: n-1) * n
    }
}

print(factorial(n: 5))

// 암
func minmax(_ numbers:[Int]) -> (min:Int,max:Int) {
    var min = Int.max
    var max = Int.min
    for i in numbers {
        if(i < min) {
            min = i
        }
        if(i > max) {
            max = i
        }
    }
    return (min,max)
}

print(minmax([0,3,2,1,4,0129,123,-1,23,48]))

// 가변 파라미터
func sumFunc(_ numbers:Int...) -> Int {
    var result = 0
    for i in numbers {
        result += i
    }
    
    return result
}

var sum = sumFunc(1,2,3,4,5,6,7,8,9,10)

// 함수 타입
let funcCanBeVar:(Int...) -> Int = sumFunc
print(funcCanBeVar(1,2,3,4,5))

//: in-out 파라미터
// 가변 파라미터는 in-out 형으로 못씀. in-out 파라미터는 기본값 지정 불가
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var a = 10
var b = 20
swapTwoInts(&a, &b)
print("\(a) , \(b)")

// 파라미터에 함수 타입 사용하기
func exeFunc(_ swapFunction:(_ a:inout Int,_ b:inout Int) -> Any?,a:inout Int,b:inout Int) {
    swapFunction(&a,&b)
    print("\(a) , \(b) swaped")
}

exeFunc(swapTwoInts, a: &a, b: &b)

// 반환값으로 함수 타입 받기
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}
chooseStepFunction(backward: true)(10)

// 다른 함수에 포함된 함수
func chooseStepFunctionTwo(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}


//: Closure = lambda, block
// { (parameters) -> returnType in
// statements
// }
// Closure 는 Reference Type

//: Closure 특징
// 1. 파라미터와 리턴값에 대한 추론(inference) = 코드 생략 가능
// 2. 1줄만 작성된 클로저는 묵시적으로 return 값으로 사용됨
// 3. 아규먼트 이름 축약
// 4. 마지막에 오는 클로저는 () 생략 가능

var numbers = [49,123,32,11,3,2,402,1]
// mutating func sort(by areInIncreasingOrder: (Element, Element) -> Bool)
numbers.sort(by:{(a :Int, b:Int) -> Bool in return a>b})
print(numbers)
// 추론 1단계. 파라미터 타입과 리턴 타입을 알고 있음
numbers.sort(by:{ (a , b ) in return a < b })
print(numbers)
// 추론 2단계. 1줄만 작성된 클로저는 그 행이 리턴값이 됨. return 키워드 생략.
numbers.sort(by:{ (a , b ) in a > b })
print(numbers)
// 추론 3단계. 아규먼트 이름 생략. 아규먼트 이름은 순서대로 $0, $1, $2 ....
numbers.sort(by:{ $0 < $1 })
print(numbers)
// 마지막 파라미터가 클로저일 경우 () 밖에 클로저 쓰는게 가능
numbers.sort() { $0 > $1 }
print(numbers)
// 파라미터가 1개이고, 그것이 클로저일 경우 () 생략 가능
numbers.sort{ $0 < $1 }
print(numbers)
// Operator를 Closure 대신에 사용 가능.
numbers.sort(by:<)
print(numbers)


// 변수 붙들기.

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0 // 이 변수가 closure 안에 Caputured 되어 있다.
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
var incrementerFunc = makeIncrementer(forIncrement: 10)
let incrementerResult = incrementerFunc()
let incre2 = incrementerFunc()

// Escaping Closure
// 클로저가 함수에 파라미터로 전달 되었지만, 함수가 종료 된 다음에 클로저가 실행되는 것을 함수에서 탈출했다고 한다. 이것을 문법적으로 나타내기 위해서 @escape 수식어를 쓸 수 있다.
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

// escape 클로저는 self 키워드를 사용해야 한다. 클로저에서 self 키워드를 사용함으로써 명시적으로 해당 변수를 "Capture" 할 수 있기 때문이다. 컴파일러가 문법 에러 체크해줌.
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
print(instance.x)
instance.doSomething()
print(instance.x)
//print 200

completionHandlers.forEach { $0() }
print(instance.x)
// Prints "100"

//: Autoclosure
// { } 로 감싼 구문은 클로저로 만들어주는 것. 아래처럼 단순한 형태도 있지만, 가변 파라미터를 쓸 수도 있다. 일반적으로 즉시 실행되지 않기 때문에 좋다.
let autoclosureSample:() -> Bool = {
    print("autoclosure called")
    return true
}
autoclosureSample()

// assert 가 대표적인 autoclosure 사용처라고 함.
//
//@_transparent
//public func assert(
//    _ condition: @autoclosure () -> Bool,
//    _ message: @autoclosure () -> String = String(),
//    file: StaticString = #file, line: UInt = #line
//    ) {
//    // Only assert in debug mode.
//    if _isDebugAssertConfiguration() {
//        if !_branchHint(condition(), expected: true) {
//            _assertionFailure("Assertion failed", message(), file: file, line: line,
//                              flags: _fatalErrorFlags())
//        }
//    }
//}

// : @autoclosure와 @escaping 같이 사용 가능.
