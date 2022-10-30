import Foundation

/*

Week 188:

    https://perlweeklychallenge.org/blog/perl-weekly-challenge-188

Task #2: Total Zero

    You are given two positive integers $x and $y.

    Write a script to find out the number of operations needed to
    make both ZERO. Each operator is made up either of the following:

        $x = $x - $y if $x >= $y

        or

        $y = $y - $x if $y >= $x

ACTION:

     $ swift ch-2.swift 5 4
     $ swift ch-2.swift 4 6
     $ swift ch-2.swift 2 5
     $ swift ch-2.swift 3 1
     $ swift ch-2.swift 7 4

*/

enum ParamError: Error {
    case missingX
    case missingY
    case invalidX
    case invalidY
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingX
    }

    if paramCount <= 2 {
        throw ParamError.missingY
    }

    var x:Int = Int(CommandLine.arguments[1])!
    var y:Int = Int(CommandLine.arguments[2])!

    if x > 0 {
        if y > 0 {
            var count:Int = 0
            while (x > 0 && y > 0) {
                if (x >= y) {
                    x = x - y
                }
                else {
                    y = y - x
                }
                count = count + 1
            }

            print(count)
        }
        else {
            throw ParamError.invalidY
        }
    }
    else {
        throw ParamError.invalidX
    }
}
catch ParamError.missingX {
    print("Missing x.")
}
catch ParamError.missingY {
    print("Missing y.")
}
catch ParamError.invalidX {
    print("Invalid x.")
}
catch ParamError.invalidY {
    print("Invalid y.")
}
catch let error {
    print(error)
}
