import Foundation

/*

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task 2: Reversible Numbers

    Write a script to find out all Reversible Numbers below 100.

ACTION:

    $ swift ch-2.swift 100

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
    if num >= 1 {
        for i in 1...num {
            if hasAllOddDigits(i + reverseInt(i)) {
                print(i)
            }
        }
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
// Functions

func hasAllOddDigits(_ n: Int) -> Bool {
    let digits:[Int] = n.digits

    for i in digits {
        if i % 2 == 0 {
            return false
        }
    }

    return true
}

func reverseInt(_ n: Int) -> Int {
    var num: Int = n
    var rev: Int = 0

    while (num != 0) {
        rev = rev * 10
        rev = rev + num % 10
        num = num / 10
    }

    return rev
}

extension Int {
    var digits : [Int] {
        var result = [Int]()
        var remaining = abs(self)
        while remaining > 0 {
            result.insert(remaining % 10, at: 0)
            remaining /= 10
        }
        return result
    }
}
