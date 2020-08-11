import Foundation

/*
Perl Weekly Challenge - 072

Task #1: Trailing Zeroes

https://perlweeklychallenge.org/blog/perl-weekly-challenge-072
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

    let number:Int = Int(CommandLine.arguments[1])!
    if number <= 0 || number > 10 {
        throw ParamError.invalidNumber
    }

    print(countTrailingZeroes(calculateFactorial(number)))
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
// Functions

func calculateFactorial(_ number:Int) -> String {

    var n:Int = number
    for i in 1..<n {
        n = n * i
    }

    return String(n)
}

func countTrailingZeroes(_ factorial:String) -> Int {

    let pattern = "^[1-9]+?(?<zero>[0]+)$"
    let regex   = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)

    if let match = regex?.firstMatch(
                   in: factorial,
                   options: [],
                   range: NSRange(location: 0,
                                  length: factorial.utf16.count)) {

        if let zeroMatch = Range(match.range(withName: "zero"), in: factorial) {
            return factorial[zeroMatch].count
        }
    }

    return 0
}
