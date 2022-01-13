import Foundation

/*

Week 139:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-139

Task #1: JortSort

    You are given a list of numbers.

    Write a script to implement JortSort. It should return true/false depending if the given list of numbers are already sorted.

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

    let l:String = CommandLine.arguments[1]
    if isValidList(l) {
        let n = l.components(separatedBy: ",")
        var s = n
        s.sort()

        var status:Int = 1
        for i in 0...n.count-1 {
            let _n:Int = Int(n[i])!
            let _s:Int = Int(s[i])!

            if _n != _s {
                status = 0
                break
            }
        }

        print(status)

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
