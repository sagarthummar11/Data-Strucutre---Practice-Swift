import Foundation

public struct Stack<Element> {
    fileprivate var storage: [Element] = []
    
    public init() { }
    
    public init(_ elements: [Element]) {
        storage = elements
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    
    public func peek() -> Element? {
     storage.last
    }

    public var isEmpty: Bool {
      peek() == nil
    }
}

extension Stack: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        ----top----
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        -----------
        """
    }
}

//Normal Initialization
var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)
stack.push(5)

print(stack)

stack.pop()
print(stack)

//Array Initialisation
var arrInitStack = Stack<String>(["A","B","C"])
print(arrInitStack)

extension Stack: ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
    
}

//Array Protocol
var protoStack: Stack = ["12", "23", "34"]
print(protoStack)

//---------------------------------------//
//Challenge:- Balance the Parenthesis
//Example:
//1. h((e))llo(world)() // balanced parentheses
//2. (hello world // unbalanced parentheses
//---------------------------------------//

func checkBalanceTheParenthesis(_ string: String) -> Bool {
    var charStack = Stack<Character>()
    
    for char in string {
        if char == "(" {
            charStack.push(char)
        }
        
        if char == ")" {
            if charStack.isEmpty {
                return false
            } else {
                charStack.pop()
            }
        }
    }
    
    return charStack.isEmpty
}

let string1 = ")h((e))llo(world)()"
checkBalanceTheParenthesis(string1)

let string2 = "(hello world"
checkBalanceTheParenthesis(string2)


