import Foundation

/*
Perl Weekly Challenge - 066

Task #1: Divide Integers

https://perlweeklychallenge.org/blog/perl-weekly-challenge-066/
*/

enum ParamError: Error {
    case missingDividendAndDivisor
    case missingDivisor
    case invalidDividend
    case invalidDivisor
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingDividendAndDivisor
    }
    else if paramCount <= 2 {
        throw ParamError.missingDivisor
    }

    let dividend:Int = Int(CommandLine.arguments[1])!
    let divisor:Int  = Int(CommandLine.arguments[2])!

    var abs_dividend = abs(dividend)
    let abs_divisor  = abs(divisor)

    if abs_dividend < abs_divisor {
        throw ParamError.invalidDividend
    }

    if divisor == 0 {
        throw ParamError.invalidDivisor
    }

    var sign:String = "";
    if dividend < 0 {
        if divisor > 0 {
            sign = "-"
        }
    }
    else {
        if divisor < 0 {
            sign = "-"
        }
    }

    var i:Int = 0
    while abs_dividend >= abs_divisor {
        i += 1
        abs_dividend -= abs_divisor
    }

    if sign != "" {
        i += 1
        print(i)
    }
    else {
        print(sign + String(i))
    }
}
catch ParamError.missingDividendAndDivisor {
    print("Missing Dividend and Divisor")
}
catch ParamError.missingDivisor {
    print("Missing Divisor")
}
catch ParamError.invalidDividend {
    print("Invalid Dividend. (Dividend > Divisor)")
}
catch ParamError.invalidDivisor {
    print("Invalid Divisor. Divisor > 0")
}
catch let error {
    print(error)
}
