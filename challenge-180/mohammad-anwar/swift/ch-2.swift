import Foundation

/*

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #1: Trim List

    You are given list of numbers, @n and an integer $i.

    Write a script to trim the given list where element is less than
    or equal to the given integer.

ACTION:

    $ swift ch-2.swift 3 "1, 4, 2, 3, 5"
    $ swift ch-2.swift 4 "9, 0, 6, 2, 3, 8, 5"

*/

enum ParamError: Error {
    case missingNumber
    case missingList
    case invalidList
}
do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 2 {
        throw ParamError.missingNumber
    }

    if paramCount <= 1 {
        throw ParamError.missingList
    }

    let num: Int     = Int(CommandLine.arguments[1])!
    let list: String = CommandLine.arguments[2]

    if isValidList(list) {
        let array = list.components(separatedBy: ", ")
        var trimList = [Int]()
        for i in array {
            if (Int(i)! > num) {
                trimList.append(Int(i)!)
            }
        }
        print(trimList)
    }
    else {
        throw ParamError.invalidList;
    }
}
catch ParamError.missingNumber {
    print("Missing number.")
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
