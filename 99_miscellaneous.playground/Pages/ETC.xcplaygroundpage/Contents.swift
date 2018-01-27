//: Bridge, Toll-free

// Objective-C / C / Swift 간의 구조체나 클래스이 특별한 형변 없이도 사용 할수 있게 되어있는 것.
// Swift Dictionary = Objective-C NSDictionary 처럼 사용 할 수 있음


//: Hashable 에 대해서

//You can use your own custom types as set value types or dictionary key types by making them conform to the Hashable protocol from Swift’s standard library. Types that conform to the Hashable protocol must provide a gettable Int property called hashValue. The value returned by a type’s hashValue property is not required to be the same across different executions of the same program, or in different programs.
//
//Because the Hashable protocol conforms to Equatable, conforming types must also provide an implementation of the equals operator (==). The Equatable protocol requires any conforming implementation of == to be an equivalence relation. That is, an implementation of == must satisfy the following three conditions, for all values a, b, and c:
//
//a == a (Reflexivity)
//
//a == b implies b == a (Symmetry)
//
//a == b && b == c implies a == c (Transitivity)
