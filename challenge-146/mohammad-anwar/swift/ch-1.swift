import Foundation

/*

Week 146:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-146

Task #1: 10001st Prime Number

    Write a script to generate the 10001st prime number.

*/

enum ParamError: Error {
    case missingIndex
    case invalidIndex
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingIndex
    }

    let count:Int = Int(CommandLine.arguments[1])!
    if count > 0 {
        var c:Int = 0
        var n:Int = 2
        while c <= count {
            if isPrime(n) == 1 {
                c += 1
                if c == count {
                    print(n)
                }
            }
            n += 1
        }
    }
    else {
        throw ParamError.invalidIndex
    }
}
catch ParamError.missingIndex {
    print("Missing index count.")
}
catch ParamError.invalidIndex {
    print("Invalid index count.")
}
catch let error {
    print(error)
}

//
//
// Functions

func isPrime(_ n:Int) -> Int {
    let j:Int = Int(sqrt(Float(n)))
    if j >= 2 {
        for i in 2...j {
            if n % i == 0 {
                return 0
            }
        }
    }
    return 1
}
