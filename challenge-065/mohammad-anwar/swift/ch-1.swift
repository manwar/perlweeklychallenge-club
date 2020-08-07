import Foundation

/*
Perl Weekly Challenge - 065

Task #1: Digits Sum

https://perlweeklychallenge.org/blog/perl-weekly-challenge-065/
*/

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingDigitsAndSum
    }
    else if paramCount <= 2 {
        throw ParamError.missingSum
    }

    let digits:String = String(CommandLine.arguments[1])
    let sum:String    = String(CommandLine.arguments[2])

    let start:Int = try startIndex(d: digits)
    let stop:Int  = try stopIndex(d: digits)

    print(digitsSum(start, stop, sum))
}
catch ParamError.missingDigitsAndSum {
    print("Missing Digits and Sum")
}
catch ParamError.missingDigits {
    print("Missing Digits")
}
catch ParamError.missingSum {
    print("Missing Sum")
}
catch let error {
    print(error)
}

//
//
// Functions

enum ParamError: Error {
    case missingDigitsAndSum
    case missingDigits
    case missingSum
}

func digitsSum(_ start:Int, _ stop:Int, _ sum:String) -> String {

    var s:String = ""
    for i in start...stop {
        let _sum:String = sumDigits(n: String(i))
        if sum == _sum {
            if s == "" {
                s = String(i)
            }
            else {
                s = s + ", " + String(i)
            }
        }
    }

    return s
}

func startIndex(d digits:String) throws -> Int {

    guard let count:Int = Int(digits) else {
        throw ParamError.missingDigits
    }

    var index:String = "1"
    for _ in 1..<count {
        index = index + "0"
    }

    guard let s:Int = Int(index) else { return Int() }
    return s
}

func stopIndex(d digits:String) throws -> Int {

    guard let count:Int = Int(digits) else {
        throw ParamError.missingDigits
    }

    var index:String = ""
    for _ in 1...count {
        index = index + "9"
    }

    guard let s:Int = Int(index) else { return Int() }
    return s
}

func sumDigits(n number:String) -> String {

    let digits  = Array(number)
    var sum:Int = 0

    for i in digits {
        if let i:Int = Int(String(i)) {
            sum = sum + i
        }
    }

    return String(sum)
}
