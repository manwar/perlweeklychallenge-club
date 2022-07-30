import Foundation

/*

Week 175:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-175

Task #2: Perfect Totient Numbers

    Write a script to generate first 20 Perfect Totient Numbers.

ACTION:

    $ swift ch-2.swift 20

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
        var i:Int = 0
        var j:Int = 1
        while i < num {
            if isPerfectTotient(j) {
                print(j)
                i = i + 1
            }
            j = j + 1
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

func isCoprime(_ m: Int, _ n: Int) -> Bool {
    var a: Int = 0
    var b: Int = max(m, n)
    var r: Int = min(m, n)

    while r != 0 {
        a = b
        b = r
        r = a % b
    }

    return b == 1
}

func isPerfectTotient(_ n:Int) -> Bool {
    var i: Int = n
    var s: Int = 0
    while i >= 1 {
        var coprimes:[Int] = []
        for j in 1..<i {
            if isCoprime(j, i) {
                coprimes.append(j)
            }
        }
        i = coprimes.count
        s = s + i
    }

    return n == s
}
