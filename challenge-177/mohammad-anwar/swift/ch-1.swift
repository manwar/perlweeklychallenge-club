import Foundation

/*

Week 177:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-177

Task #1: Damm Algorigthm

    You are given a positive number, $n.

    Write a script to validate the given number against the included
    check digit.

ACTION:

    $ swift ch-1.swift 5724

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
    if (num > 0) {
        let op_table:[[Int]] = [
            [ 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 ],
            [ 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 ],
            [ 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 ],
            [ 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 ],
            [ 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 ],
            [ 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 ],
            [ 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 ],
            [ 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 ],
            [ 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 ],
            [ 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 ],
        ]
        var n:[Int] = num.digits
        let c:Int   = n.removeLast()
        var i:Int   = 0
        for j in n {
        	i = op_table[i][j]
        }

        if i == c {
        	print("it is valid.")
        }
        else {
        	print("it is invalid.")
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
// Local extension

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
