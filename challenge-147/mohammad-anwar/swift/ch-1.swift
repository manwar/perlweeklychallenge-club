import Foundation

/*

Week 147:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-147

Task #1: Truncatable Prime

    Write a script to generate first 20 left-truncatable prime numbers in base 10.

*/

enum ParamError: Error {
    case missingCount
    case invalidCount
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingCount
    }

    let count:Int = Int(CommandLine.arguments[1])!
    if count > 0 {
        var c:Int = 0
        var n:Int = 2
        while c < count {
            if !containZero(String(n)) && isPrime(n) {
                let numbers:[Int] = leftTruncatableNumbers(n)
                var found:Bool    = true
                if numbers.count >= 2 {
                    for _n in numbers {
                        if !isPrime(_n) {
                            found = false
                        }
                    }
                }

                if found {
                    print(n)
                    c += 1
                }
            }

            n += 1
        }
    }
    else {
        throw ParamError.invalidCount
    }
}
catch ParamError.missingCount {
    print("Missing index count.")
}
catch ParamError.invalidCount {
    print("Invalid index count.")
}
catch let error {
    print(error)
}

//
//
// Functions

func containZero(_ n:String) -> Bool {

    let pattern = "0"
    let regex   = try! NSRegularExpression(pattern: pattern)
    let range   = NSRange(location: 0, length: n.utf16.count)

    if regex.firstMatch(in: n, options: [], range: range) != nil {
        return true
    }
    else {
        return false
    }
}

func leftTruncatableNumbers(_ n:Int) -> Array<Int> {
    var numbers  = [Int]()
    var i:Int    = 0
    let s:String = String(n)
    let l:Int    = s.count - 1
    while i < s.count {
        numbers.append(Int(String(Array(s)[i...l]))!)
        i += 1
    }

    return numbers;
}

func isPrime(_ n:Int) -> Bool {
    if n == 1 {
        return false
    }

    let j:Int = Int(sqrt(Float(n)))
    if j >= 2 {
        for i in 2...j {
            if n % i == 0 {
                return false
            }
        }
    }
    return true
}
