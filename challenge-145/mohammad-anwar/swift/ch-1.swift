import Foundation

/*

Week 145:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-145

Task #1: Dot Product

    You are given 2 arrays of same size, @a and @b.

    Write a script to implement Dot Product.

*/

enum ParamError: Error {
    case missingListA
    case missingListB
    case invalidListA
    case invalidListB
    case mismatchList
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingListA
    }
    if paramCount <= 2 {
        throw ParamError.missingListB
    }

    let a:String = CommandLine.arguments[1]
    let b:String = CommandLine.arguments[2]
    if isValidList(a) {
        if isValidList(b) {
            let list_a = a.components(separatedBy: ",")
            let list_b = b.components(separatedBy: ",")

            if list_a.count == list_b.count {
                var dp:Int = 0
                for i in 0...list_a.count-1 {
                    let _a:Int = Int(list_a[i])!
                    let _b:Int = Int(list_b[i])!

                    dp += _a * _b
                }

            	print(dp)
            }
            else {
            	throw ParamError.mismatchList
            }
        }
        else {
            throw ParamError.invalidListB
        }
    }
    else {
        throw ParamError.invalidListA
    }
}
catch ParamError.missingListA {
    print("Missing list A.")
}
catch ParamError.missingListB {
    print("Missing list B.")
}
catch ParamError.invalidListA {
    print("Invalid list A.")
}
catch ParamError.invalidListB {
    print("Invalid list B.")
}
catch ParamError.mismatchList {
    print("Mismatch list.")
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
