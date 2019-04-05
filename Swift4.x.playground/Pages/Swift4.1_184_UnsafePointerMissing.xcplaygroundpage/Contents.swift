//: [Previous](@previous)

import Foundation

//: # UnsafePointer 보완
//:  https://github.com/apple/swift-evolution/blob/master/proposals/0184-unsafe-pointers-add-missing.md

//: Pointer 는 저수준 메모리 프로그래밍의 중요한 인터페이스이지만, 기존에 이를 충족시키지 못했다.
//: 최종 목표는 UnsafeMutablePointer, UnsafeMutableRawPointer 의 모든 기능을 버퍼타입인 UnsafeMutableBufferPointer, UnsafeMutableRawBufferPointer 에 이식하는 것이다.
//: 이 제안에서는 allocation, deallocation, type rebinding 을 다룬다.
//: 아래 목록에서 --- 는 삭제된 메소드, +++는 추가된 메소드를 의미한다.

struct UnsafePointer<Pointee>
{
    +++ func deallocate()
    
    func withMemoryRebound<T, Result>(to:T.Type, capacity:Int, _ body:(UnsafePointer<T>) -> Result)
        -> Result
}

struct UnsafeMutablePointer<Pointee>
{
    static func allocate<Pointee>(capacity:Int) -> UnsafeMutablePointer<Pointee>
    
    --- func deallocate(capacity:Int)
    +++ func deallocate()
    
    --- func initialize(to:Pointee, count:Int = 1)
    +++ func initialize(repeating:Pointee, count:Int)
    +++ func initialize(to:Pointee)
    func initialize(from:UnsafePointer<Pointee>, count:Int)
    func moveInitialize(from:UnsafeMutablePointer<Pointee>, count:Int)
    
    +++ func assign(repeating:Pointee, count:Int)
    func assign(from:UnsafePointer<Pointee>, count:Int)
    func moveAssign(from:UnsafeMutablePointer<Pointee>, count:Int)
    
    func deinitialize(count:Int)
    
    func withMemoryRebound<T, Result>(to:T.Type, capacity:Int, _ body:(UnsafeMutablePointer<T>) -> Result)
        -> Result
}

struct UnsafeRawPointer
{
    --- func deallocate(bytes:Int, alignedTo:Int)
    +++ func deallocate()
    
    func bindMemory<T>(to:T.Type, count:Int) -> UnsafeMutablePointer<T>
}

struct UnsafeMutableRawPointer
{
    --- static
    --- func allocate(bytes:Int, alignedTo:Int) -> UnsafeMutableRawPointer
    +++ static
    +++ func allocate(byteCount:Int, alignment:Int) -> UnsafeMutableRawPointer
    --- func deallocate(bytes:Int, alignedTo:Int)
    +++ func deallocate()
    
    --- func initializeMemory<T>(as:T.Type, at:Int = 0, count:Int = 1, to:T) -> UnsafeMutablePointer<T>
    +++ func initializeMemory<T>(as:T.Type, repeating:T, count:Int) -> UnsafeMutablePointer<T>
    
    func initializeMemory<T>(as:T.Type, from:UnsafePointer<T>, count:Int) -> UnsafeMutablePointer<T>
    func moveInitializeMemory<T>(as:T.Type, from:UnsafeMutablePointer<T>, count:Int)
        -> UnsafeMutablePointer<T>
    
    func bindMemory<T>(to:T.Type, count:Int) -> UnsafeMutablePointer<T>
    
    --- func copyBytes(from:UnsafeRawPointer, count:Int)
    +++ func copyMemory(from:UnsafeRawPointer, byteCount:Int)
}

struct UnsafeBufferPointer<Element>
{
    +++ init(_:UnsafeMutableBufferPointer<Element>)
    
    +++ func deallocate()
    
    +++ func withMemoryRebound<T, Result>
    +++ (to:T.Type, _ body:(UnsafeBufferPointer<T>) -> Result)
}

struct UnsafeMutableBufferPointer<Element>
{
    +++ init(mutating:UnsafeBufferPointer<Element>)
    
    +++ static
    +++ func allocate<Element>(capacity:Int) -> UnsafeMutableBufferPointer<Element>
    
    +++ func initialize(repeating:Element)
    +++ func assign(repeating:Element)
    
    +++ func withMemoryRebound<T, Result>
    +++ (to:T.Type, _ body:(UnsafeMutableBufferPointer<T>) -> Result)
}

struct UnsafeRawBufferPointer
{
    func deallocate()
    
    +++ func bindMemory<T>(to:T.Type) -> UnsafeBufferPointer<T>
}

struct UnsafeMutableRawBufferPointer
{
    --- static func allocate(count:Int) -> UnsafeMutableRawBufferPointer
    +++ static func allocate(byteCount:Int, alignment:Int) -> UnsafeMutableRawBufferPointer
    func deallocate()
    
    +++ func initializeMemory<T>(as:T.Type, repeating:T) -> UnsafeMutableBufferPointer<T>
    
    +++ func bindMemory<T>(to:T.Type) -> UnsafeMutableBufferPointer<T>
    
    --- func copyBytes(from:UnsafeRawBufferPointer)
    +++ func copyMemory(from:UnsafeRawBufferPointer)
}




//: [Next](@next)
