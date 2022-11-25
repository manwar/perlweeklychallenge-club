import Foundation

/*

Week 192:

    https://perlweeklychallenge.org/blog/perl-weekly-challenge-192

Task #1: Binary Flip

    You are given a positive integer, $n.

    Write a script to find the binary flip.

ACTION:

     $ swift ch-1.swift 5
     $ swift ch-1.swift 4
     $ swift ch-1.swift 6

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
        let binary:String  = String(num, radix: 2)
        var flipped:String = ""
        Array(binary).forEach{ flipped += ($0 == "0") ? "1" : "0" }
        print(Int(flipped, radix: 2)!)
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
