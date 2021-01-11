import Foundation

//Single Linked List

public class Node<Value> {
    
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    
    public var description: String {
        guard let next = next else { return "\(value)" }
        
        return "\(value) -> " + String(describing: next) + " "
    }
}


let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)
let node4 = Node(value: 4)

node1.next = node2
node2.next = node3
node3.next = node4

print("Linked List:-")
print(node1)
print("")

//Double Linked List

public struct LinkedList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() { }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    //Find a node at index
    func node(at index: Int) -> Node<Value>? {
        
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
}

//Insertion Operation
extension LinkedList {
    /* Adding a value in the List by Three ways:
        1. Puch (Add value at front of the List)
        2. Append (Append value at End of the List)
        3. Insert at Position (Insert value at any position)
     */
    
    /* 1. Push Operation */
    mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    /* 2. Append Operation */
    mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail?.next = Node(value: value)
        
        tail = tail?.next
    }
    
    /* 3. Insert at Position Operation */
    
    @discardableResult
    mutating func insert(_ value: Value, afterNode node: Node<Value>) -> Node<Value> {
        
        //Perform append operation if need append at the end of the list
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        
        return node.next!
    }
}

//Remove Operation
extension LinkedList {
    
    /* Remove Value from the Linked List
        1. Pop: Remove value from the front of the List
        2. RemoveLast: Remove last element of the List
        3. Remove At: Remove a value from anywhere of the List
     */
    
    //1. Pop Operation
    @discardableResult
    mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    //2. RemoveLast Operation
    @discardableResult
    mutating func removeLast() -> Value? {
        guard let head = head else { return nil }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prevNode = head
        var currentNode = head
        
        while let nextNode = currentNode.next {
            prevNode = currentNode
            currentNode = nextNode
        }
        
        prevNode.next = nil
        tail = prevNode
        return currentNode.value
    }
    
    //3. Remove At Operation
    @discardableResult
    mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        
        return String(describing: head)
    }
}

print("Insertion Operation:- ")
var list = LinkedList<Int>()
list.push(1)
list.push(2)

list.append(3)
list.append(4)

let thirdNode = list.node(at: 2)!
list.insert(5, afterNode: thirdNode)

print(list)
print("")

print("Remove Operation:- ")
list.pop()
list.removeLast()

let secondNode = list.node(at: 0)!
list.remove(after: secondNode)

print(list)
print("")

