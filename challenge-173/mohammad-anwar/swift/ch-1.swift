import Foundation

/*

Week 173:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-173

Task #1: Esthetic Number

    You are given a positive integer, $n.

    Write a script to find out if the given number is Esthetic Number.

*/

enum ParamError: Error {
    case missingNumber
    case invalidNumber
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingNumber
    }

    let num:Int = Int(CommandLine.arguments[1])!
    if num > 0 {
        print(isEstheticNumber(num))
    }
    else {
        throw ParamError.invalidNumber
    }
}
catch ParamError.missingNumber {
    print("Missing number.")
}
catch ParamError.invalidNumber {
    print("Invalid number.")
}
catch let error {
    print(error)
}

//
//
// Function

func isEstheticNumber(_ n:Int) -> Bool {
    let s:String = String(n)
    let l:Int    = s.count - 1
    for i in 1...l {
        let a:Int = Int(String(Array(s)[i - 1]))!
        let b:Int = Int(String(Array(s)[i]))!
        if abs(a - b) != 1 {
            return false
        }
    }

    return true;
}
