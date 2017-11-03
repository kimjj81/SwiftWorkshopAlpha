//: [Previous](@previous)

import Foundation
import UIKit

protocol Drawable {
    func draw(rect:CGRect)
    var frame:CGRect { get set }
}

struct 사각형 : Drawable {
    public var frame: CGRect
    
    func draw(rect: CGRect) {
        // draw something
    }
}

extension 사각형 : Equatable { }

struct 원 : Drawable {
    public var frame:CGRect
    
    func draw(rect:CGRect) {
        // draw something
    }
}
extension 원 : Equatable { }

func ==<T : Drawable & Equatable, W : Drawable & Equatable>(lhs:T,rhs:W) -> Bool  {
    return (lhs.frame == lhs.frame) && (type(of: lhs) == type(of: rhs))
}

let rect = 사각형.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
let circle = 원.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))

print(rect == circle)

let circle1 = 원.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100) )
let circle2 = 원.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100) )

print(circle1 == circle2)
//: [Next](@next)
