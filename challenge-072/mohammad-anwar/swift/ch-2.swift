import Foundation

/*
Perl Weekly Challenge - 072

Task #2: Lines Range

https://perlweeklychallenge.org/blog/perl-weekly-challenge-072
*/

enum ParamError: Error {
    case missingFile
    case missingA
    case missingB
    case invalidA
    case invalidB
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingFile
    }

    if paramCount <= 2 {
        throw ParamError.missingA
    }

    if paramCount <= 3 {
        throw ParamError.missingB
    }

    let fileName:String = CommandLine.arguments[1]
    let a:Int = Int(CommandLine.arguments[2])!
    let b:Int = Int(CommandLine.arguments[3])!

    if a <= 0 || a > b {
        throw ParamError.invalidA
    }
    if b <= 0 {
        throw ParamError.invalidB
    }

    let ranges:[String] = linesRange(fileName, a, b)
    print(ranges.joined(separator: "\n"))
}
catch ParamError.missingFile {
    print("Missing file.")
}
catch ParamError.missingA {
    print("Missing A.")
}
catch ParamError.missingB {
    print("Missing B.")
}
catch ParamError.invalidA {
    print("Invalid A.")
}
catch ParamError.invalidB {
    print("Invalid B.")
}
catch let error {
    print(error)
}

//
//
// Function

func linesRange(_ fileName:String, _ a:Int, _ b:Int) -> [String] {

    let contents = try! String(contentsOfFile: fileName)
    let lines    = contents.split(separator:"\n")

    var ranges = [String]()
    for i in a-1...b-1 {
        ranges.append(String(lines[i]))
    }

    return ranges
}
