//: [Previous](@previous)

import Foundation

//: 모듈이 있는지 없는지를 판단해서 방어코드나 대응 코드를 넣을 수 있게 한다.
//: 이전에는 OS 검사를 하는 경우가 있었는데, UIColor 처럼 iOS, Linux 에 둘 다 존재하는 경우는 이것으로 OS 구분을 못하게 된다.

#if canImport(UIKit)
// UIKit-based code : iOS가 되겠음.
#elseif canImport(Cocoa)
// OSX code : macOS 일 경우
#elseif
// 그 외의 경우
#endif

//: 현재 가능한 코드
//: * os() : 실행 OS 검사  OSX, iOS, watchOS, tvOS, Linux, Windows, FreeBSD
//: * arch() : 실행 CPU 아키텍처 검사  x86_64, arm, arm64, i386, powerpc64, powerpc64le
//: * swift() : 스위프트 버전 검사 , 예) swift(>=2.2)

//: [Next](@next)
