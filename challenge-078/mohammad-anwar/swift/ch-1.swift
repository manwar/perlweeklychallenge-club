import Foundation

/*

Perl Weekly Challenge - 078

Task #1: Leader Element

https://perlweeklychallenge.org/blog/perl-weekly-challenge-078

*/

enum ParamError: Error {
    case missingList
    case invalidList
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingList
    }

    let list:String = CommandLine.arguments[1]
    if isValidList(list) {
        let array = list.components(separatedBy: ", ")

        var index:Int = 0;
        var leaderElements = [Int]();
        while index < array.count - 1 {
            let max:Int     = findMax(array, index + 1)
            let current:Int = Int(array[index])!

            if current > max {
                leaderElements.append(current)
            }
            index += 1
        }
        leaderElements.append(Int(array[index])!)

        print(array)
        print(leaderElements)
    }
    else {
        throw ParamError.invalidList
    }
}
catch ParamError.missingList {
    print("Missing list.")
}
catch ParamError.invalidList {
    print("Invalid list.")
}
catch let error {
    print(error)
}

//
//
// Functions

func isValidList(_ list:String) -> Bool {

    let pattern = "^[\\-?\\d\\,?\\s?]+$"
    let regex   = try! NSRegularExpression(pattern: pattern)
    let range   = NSRange(location: 0, length: list.utf16.count)

    if regex.firstMatch(in: list, options: [], range: range) != nil {
        return true
    }
    else {
        return false
    }
}

func findMax(_ array: [String], _ start:Int) -> Int {

    var window = [Int]()
    for i in start...array.count-1 {
        window.append(Int(array[i])!)
    }

    return window.max()!
}
