import Foundation


/// Writes the textual representation of each
/// element of `items` to the standard output.
///
/// The textual representation for each item `x`
/// is generated by the expression `String(x)`.
///
/// - Parameter separator: text to be printed
///   between items.
/// - Parameter terminator: text to be printed
///   at the end.
///
/// - Note: To print without a trailing
///   newline, pass `terminator: ""`
///
/// - SeeAlso: `CustomDebugStringConvertible`,
///   `CustomStringConvertible`, `debugPrint`.
public func print(
    _ items: Any..., separator: String = " ", terminator: String = "\n") {
        // Empty
    }

/// Int 타입의 두 수를 파라미터로 받아 덧셈을 하는 함수
///
/// - Parameter a: 첫번째 수
/// - Parameter b: 두번째 수
///
/// - Note: 음수도 가능하다
public func add(_ a: Int, _b: Int) {
    
}

//struct List<Element> {
//    private(set) var rawValue: [Element]
//
//    init(_ rawValue: [Element]) {
//        self.rawValue = rawValue
//    }
//
//    mutating func remove(at position: Int) -> Element {
//        return rawValue.remove(at: position)
//    }
//}

struct List<Element> {
    private(set) var rawValue: [Element]
    
    init(_ rawValue: [Element]) {
        self.rawValue = rawValue
    }
    
    mutating func remove(_ position: Int) -> Element {
        return rawValue.remove(at: position)
    }
}


var employees = List<Int>([1, 2, 3])
employees.rawValue
//employees.remove(at: 2)
employees.rawValue

employees.remove(2) // ?????????? 2를 지우는 건가? 2번째 position을 지우는 건가..?


var str = "Hello" // 의미를 가지고 있지 않고 타입으로 네이밍함
var greeting = "Hello"
var str2 = "My name" // -> 변수의 이름 만으로 어떤 역할을 하는지 모른다..
var name = "My Name"

protocol ViewController {
//    associatedtype ViewType // 어떻게 쓰이는 타입인지 잘 모른다...
    associatedtype ContentView
}

//struct MyViewController: ViewController {
//    typealias ViewType = String // ?? String으로 써야하나ㅏ..?
//    func restock(from widgetFactory: WidgetFactory) {
        // widgetFactory 타입으로 파라미터 이름을 지어버리면 어떤 용도로 사용하지는 정확히 이해하기가 어렵다
//    }
//    func restock(from supplier: WidgetFactory) {
//}

protocol Sequence {
    associatedtype Iterator: IteratorProtocol
    // iterator 로 선언하려고했으나 겹치기 떄문에 + protocol 붙여서 네이밍
}

protocol IteratorProtocl {
    
}


final class MyNotificationCenter {
    private var observers: [String: NSObject] = [:]
    
    func add(_ observer: NSObject, for keyPath: String) {
        observers[keyPath] = observer
    }
}

let center = MyNotificationCenter()
// center.add(self, for: "myKey") // for 에 머가 들어가야할지 헷갈림