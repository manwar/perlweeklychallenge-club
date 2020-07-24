import Foundation

/*
Perl Weekly Challenge - 070

Task #1: Character Swapping

https://perlweeklychallenge.org/blog/perl-weekly-challenge-070
*/

enum ParamError: Error {
    case missingStringCountAndOffset
    case missingCountAndOffset
    case missingOffset
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingStringCountAndOffset
    }
    else if paramCount <= 2 {
        throw ParamError.missingCountAndOffset
    }
    else if paramCount <= 3 {
        throw ParamError.missingOffset
    }

    let string:String = String(CommandLine.arguments[1])
    let count:String  = String(CommandLine.arguments[2])
    let offset:String = String(CommandLine.arguments[3])

    let o:Int = Int(offset)!
    let l:Int = string.count;

    // split string
    var s:[Character] = []
    for c in string {
        s.append(c)
    }

    for i in 1...Int(count)! {
        let a:Int = i % l;
        let b:Int = (i + o) % l;
        (s[a], s[b]) = (s[b], s[a]);
    }

    // join array of characters
    print(String(s))
}
catch ParamError.missingStringCountAndOffset {
    print("Missing String, Count and Offset")
}
catch ParamError.missingCountAndOffset {
    print("Missing Count and Offset")
}
catch ParamError.missingOffset {
    print("Missing Offset")
}
catch let error {
    print(error)
}
