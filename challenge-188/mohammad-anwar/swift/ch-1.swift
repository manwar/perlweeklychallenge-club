import Foundation

/*

Week 188:

    https://perlweeklychallenge.org/blog/perl-weekly-challenge-188

Task #1: Divisible Pairs

    You are given list of integers @list of size $n and divisor $k.

    Write a script to find out count of pairs in the given list that
    satisfies the following rules.

    The pair (i, j) is eligible if and only if
    a) 0 <= i < j < len(list)
    b) list[i] + list[j] is divisible by k

ACTION:

     $ swift ch-1.swift "4, 5, 1, 6" 2
     $ swift ch-1.swift "1, 2, 3, 4" 2
     $ swift ch-1.swift "1, 3, 4, 5" 3
     $ swift ch-1.swift "5, 1, 2, 3" 4
     $ swift ch-1.swift "7, 2, 4, 5" 4

*/

enum ParamError: Error {
    case missingList
    case missingDivisor
    case invalidList
    case invalidDivisor
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingList
    }

    if paramCount <= 2 {
        throw ParamError.missingDivisor
    }

    let list:String = CommandLine.arguments[1]
    let k:Int       = Int(CommandLine.arguments[2])!

    if isValidList(list) {
        if k > 0 {
            let array    = list.components(separatedBy: ", ")
            let intArray = array.map { Int($0)! }
            let size     = intArray.count
            var count    = 0

            for i in 0...size-2 {
                for j in i+1...size-1 {
                    if (intArray[i] + intArray[j]) % k == 0 {
                        count = count + 1
                    }
                }
            }

            print(count)
        }
        else {
            throw ParamError.invalidDivisor
        }
    }
    else {
        throw ParamError.invalidList
    }
}
catch ParamError.missingList {
    print("Missing list.")
}
catch ParamError.missingDivisor {
    print("Missing divisor.")
}
catch ParamError.invalidList {
    print("Invalid list.")
}
catch ParamError.invalidDivisor {
    print("Invalid divisor.")
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
