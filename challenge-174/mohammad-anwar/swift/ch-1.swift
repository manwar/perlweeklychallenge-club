import Foundation

/*

Week 174:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-174

Task #1: Disarium Numbers

    Write a script to generate first 19 Disarium Numbers.

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
        var i:Int = 0
        var c:Int = 0
        while c < num {
            if isDisariumNumber(i) {
                print(i)
                c = c + 1
            }
            i = i + 1
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

func pow(_ base:Int, _ power:Int) -> Int {
    var answer:Int = 1
    for _ in 0..<power { answer *= base }
    return answer
}

func isDisariumNumber(_ n:Int) -> Bool {
    let s:String = String(n)
    let l:Int    = s.count - 1
    var sum:Int  = 0
    for i in 0...l {
        let a:Int = Int(String(Array(s)[i]))!
        sum = sum + pow(a, (i+1))
    }

    return (sum == n)
}
