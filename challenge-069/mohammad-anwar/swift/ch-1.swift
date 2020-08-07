import Foundation

/*
Perl Weekly Challenge - 069

Task #1: Strobogrammatic Number

https://perlweeklychallenge.org/blog/perl-weekly-challenge-069
*/

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

enum ParamError: Error {
    case missingAandB
    case missingB
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingAandB
    }
    else if paramCount <= 2 {
        throw ParamError.missingB
    }

    let A:Int = Int(CommandLine.arguments[1])!
    let B:Int = Int(CommandLine.arguments[2])!

    var strobogrammatic:[Int] = []
    let digits: [Int: Int] = [6 : 9, 8 : 8, 9 : 6]
    for i in A...B {
        var found:Bool = true
        var match:String = ""
        for d in i.digits {
            if digits[d] != nil {
                match += String(digits[d]!)
            }
            else {
                found = false
                break
            }
        }

        if found {
            if String(i) == String(match.reversed()) {
                strobogrammatic.append(i)
            }
        }
    }

    print(strobogrammatic)
}
catch ParamError.missingAandB {
    print("Missing A and B")
}
catch ParamError.missingB {
    print("Missing B")
}
catch let error {
    print(error)
}
