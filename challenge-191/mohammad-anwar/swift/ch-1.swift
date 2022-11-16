import Foundation

/*

Week 191:

    https://perlweeklychallenge.org/blog/perl-weekly-challenge-1910

Task #1: Twice Largest

    You are given list of integers, @list.

    Write a script to find out whether the largest item in the list
    is at least twice as large as each of the other items.

ACTION:

     $ swift ch-1.swift "1, 2, 3, 4"
     $ swift ch-1.swift "1, 2, 0, 5"
     $ swift ch-1.swift "2, 6, 3, 1"
     $ swift ch-1.swift "4, 5, 2, 3"

*/

enum ParamError: Error {
    case missingList
    case invalidList
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingList
    }

    let list:String = CommandLine.arguments[1]
    if isValidList(list) {
        let array    = list.components(separatedBy: ", ")
        var intArray = array.map { Int($0)! }
        let size     = intArray.count

        intArray.sort()
        let max = (intArray.last)!

        var found = 1
        for i in 0...size-1 {
            if intArray[i] == max {
                continue
            }
            if intArray[i] * 2 > max {
            	found = -1
                break;
            }
        }
        print(found)
    }
    else {
        throw ParamError.invalidList
    }
}
catch ParamError.missingList {
    print("Missing list.")
}
catch ParamError.invalidList {
    print("Invalid list.")
}
catch let error {
    print(error)
}

//
//
// Function

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
