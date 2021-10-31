import Foundation

/*

Week 136:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-136

Task #2: Fibonacci Sequence

    You are given a positive number $n.

    Write a script to find how many different sequences you can create using Fibonacci numbers where the sum of unique numbers in each sequence are the same as the given number.

*/

enum ParamError: Error {
    case missingNum
    case invalidNum
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingNum
    }

    let num:Int = Int(CommandLine.arguments[1])!

    if num >= 1 {
        print(fibonacci_sequence(num))
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
catch let error {
    print(error)
}

//
//
// Function

func fibonacci_series(_ sum:Int) -> Array<Int> {

    var fibonacci:[Int] = [1, 2]
    var size:Int = fibonacci.count

    while fibonacci[size - 1] + fibonacci[size - 2] <= sum {
        fibonacci.append(fibonacci[size - 1] + fibonacci[size - 2])
        size = fibonacci.count
    }

    return fibonacci
}

func fibonacci_sequence(_ sum:Int) -> Int {

    let fibonacci:[Int] = fibonacci_series(sum)
    var count:Int = 0

    let comb = fibonacci.combinations
    for c in comb {
        if c.count == 0 {
            continue
        }

        let _sum:Int = c.reduce(0, +)

        if _sum == sum {
            count = count + 1
        }
    }

    return count
}

//
// Stackoverflow
//
// https://stackoverflow.com/questions/50264717/get-all-possible-combination-of-items-in-array-without-duplicate-groups-in-swift/50265976

extension Array {
    var combinations: [[Element]] {
        if count == 0 {
            return [self]
        }
        else {
            let tail  = Array(self[1..<endIndex])
            let head  = self[0]

            let first = tail.combinations
            let rest  = first.map { $0 + [head] }

            return first + rest
        }
    }
}
