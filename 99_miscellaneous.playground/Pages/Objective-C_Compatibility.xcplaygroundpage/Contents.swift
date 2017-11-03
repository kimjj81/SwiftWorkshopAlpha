//: [Previous](@previous)

import Foundation

//: Objective-C 에서 swift 로 작성한 것들을 사용하기 위한 방법을 소개한다.

//: # 1. CoreData
// NSManageedObject 를 상속받고, 필드 이름앞에는 @NSManaged 수식어를 붙여준다.
// Person+CoreDataClass.swift
import CoreData
class Person: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    
}

// Person+CoreDataProperties.swift
extension Person {
    @NSManaged var name: String
    @NSManaged var friends: NSSet
}


//: # 2. Protocol

//: * 프로토콜 선언 앞에 @objc 를 붙여준다.
//: * optional 앞에는 @objc optional 을 붙여준다.
import UIKit
@objc protocol MyCustomProtocol {
    var people: [Person] { get }
    
    func tableView(_ tableView: UITableView, configure cell: UITableViewCell, forPerson person: Person)
    
    @objc optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forPerson person: Person)
}

//: # 3. cocoa framework

//: https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/WorkingWithCocoaDataTypes.html#//apple_ref/doc/uid/TP40014216-CH6-ID61 링크 참조.
//: 아래 항목은 NSValue 를 통해서 Objective-C <-> Swift 간에 전달된다. 따라서 Objective-C 에서 구조체인 것도 Swift 에서는 레퍼런스 타입으로 이용된다.
//: * CATransform3D
//: * CLLocationCoordinate2D
//: * CGAffineTransform
//: * CGPoint
//: * CGRect
//: * CGSize
//: * CGVector
//: * CMTimeMapping
//: * CMTimeRange
//: * CMTime
//: * MKCoordinateSpan
//: * NSRange
//: * SCNMatrix4
//: * SCNVector3
//: * SCNVector4
//: * UIEdgeInsets
//: * UIOffset
//: [Next](@next)
