import Foundation

/*

Perl Weekly Challenge - 071

Task #2: Trim Linked List

https://perlweeklychallenge.org/blog/perl-weekly-challenge-071/

*/

class Node {
    var v:Int
    var p:Node?

    init(value: Int) {
        v = value
    }

    func trim(_ position: Int) -> Node {
        var tail:Node = self
        var count:Int = 1
        var node:Node = Node(value: 0)

        while tail.p != nil {
            if position > count {
                node = tail
            }
            else if position == count {
                if node.v != 0 {
                    node.p = tail.p!
                }
                else {
                    return tail.p!
                }
            }

            tail = tail.p!
            count += 1
        }

        if count <= position {
            node.p = nil
        }

        return self
    }

    func show() -> String {

        var node:Node = self
        var v = [String]()

        while node.p != nil {
            v.append(String(node.v))
            node = node.p!
        }
        v.append(String(node.v))

        v = v.reversed()

        return v.joined(separator: ", ")
    }

    class func createLinkedList(_ list:String) -> Node {

        let _list = list.replacingOccurrences(
                    of: " ",
                    with: "",
                    options: .literal,
                    range: nil)

        var array  = _list.components(separatedBy: ",")
        let n:Node = Node(value: Int(array.removeLast())!)
        var t:Node = n

        while array.count >= 1 {
            let _n:Node = Node(value: Int(array.removeLast())!)
            t.p  = _n
            t    = _n
        }

        return n
    }
}

enum ParamError: Error {
    case missingList
    case missingPosition
    case invalidList
    case invalidPosition
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingList
    }

    if paramCount <= 2 {
        throw ParamError.missingPosition
    }

    let list:String  = CommandLine.arguments[1]
    let position:Int = Int(CommandLine.arguments[2])!

    if isValidList(list) {
        if position >= 1 {
            print(Node.createLinkedList(list).trim(position).show())
        }
        else {
            throw ParamError.invalidPosition
        }
    }
    else {
        throw ParamError.invalidList
    }
}
catch ParamError.missingList {
    print("Missing list.")
}
catch ParamError.missingPosition {
    print("Missing position.")
}
catch ParamError.invalidList {
    print("Invalid list.")
}
catch ParamError.invalidPosition {
    print("Invalid position.")
}
catch let error {
    print(error)
}

//
//
// Functions

func isValidList(_ list:String) -> Bool {

    let pattern = "^[\\-?\\d\\,?\\s?]+$"
    let regex   = try! NSRegularExpression(pattern: pattern)
    let range   = NSRange(location: 0, length: list.utf16.count)

    if regex.firstMatch(in: list, options: [], range: range) != nil {
        return true
    }
    else {
        return false
    }
}
