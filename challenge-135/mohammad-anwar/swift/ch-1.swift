import Foundation

/*

Week 135:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-135

Task #1: Middle 3-digits

    You are given an integer.

    Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.

*/

enum ParamError: Error {
    case missingNum
    case invalidNum
    case tooShort
    case evenNumberOfDigits
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingNum
    }

    let num:String = CommandLine.arguments[1]

    if isValid(num) {

        let n:Int    = abs(Int(num)!)
        let s:String = String(n)
        let l:Int    = s.count

        if l == 1 {
            throw ParamError.tooShort
        }

        if l % 2 == 0 {
            throw ParamError.evenNumberOfDigits
        }

        let i:Int = (l / 2) - 1
        let str:String = String(n)

        let start = str.index(str.startIndex, offsetBy: i)
        let end   = str.index(str.endIndex, offsetBy: 3 - (str.count-i))
        let range = start..<end

        print(str[range])

    }
    else {
        throw ParamError.invalidNum
    }
}
catch ParamError.missingNum {
    print("Missing number.")
}
catch ParamError.invalidNum {
    print("Invalid number.")
}
catch ParamError.tooShort {
    print("Too short.")
}
catch ParamError.evenNumberOfDigits {
    print("Even number of digits.")
}
catch let error {
    print(error)
}

//
//
// Function

func isValid(_ num:String) -> Bool {

    let pattern = "^\\-?\\d+$"
    let regex   = try! NSRegularExpression(pattern: pattern)
    let range   = NSRange(location: 0, length: num.utf16.count)

    if regex.firstMatch(in: num, options: [], range: range) != nil {
        return true
    }
    else {
        return false
    }
}
