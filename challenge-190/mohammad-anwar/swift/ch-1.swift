import Foundation

/*

Week 190:

    https://perlweeklychallenge.org/blog/perl-weekly-challenge-190

Task #1: Capital Detection

    You are given a string with alphabetic characters only:
    A..Z and a..z.

    Write a script to find out if the usage of Capital is appropriate
    if it satisfies at least one of the following rules:

    1) Only first letter is capital and all others are small.
    2) Every letter is small.
    3) Every letter is capital.

ACTION:

     $ swift ch-1.swift "Perl"
     $ swift ch-1.swift "TPF"
     $ swift ch-1.swift "PyThon"
     $ swift ch-1.swift "raku"

*/

enum ParamError: Error {
    case missingString
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingString
    }

    let name:String = CommandLine.arguments[1]

    if (isValid("^[A-Za-z]+$", name)) {
        if (isValid("^[A-Z][a-z]+$", name) ||
            isValid("^[A-Z]+$", name)      ||
            isValid("^[a-z]+$", name)) {
            print("1")
        }
        else {
            print("0")
        }
    }
    else {
        print("0")
    }
}
catch ParamError.missingString {
    print("Missing string.")
}
catch let error {
    print(error)
}

//
//
// Function

func isValid(_ rule:String, _ name:String) -> Bool {
    let regx = try! NSRegularExpression(pattern: rule)
    let rang = NSRange(location: 0, length: name.utf16.count)

    if (regx.firstMatch(in: name, options: [], range: rang) != nil) {
        return true
    }
    else {
        return false
    }
}
