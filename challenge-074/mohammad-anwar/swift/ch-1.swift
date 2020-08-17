import Foundation

/*

Perl Weekly Challenge - 074

Task #1: Majority Element

https://perlweeklychallenge.org/blog/perl-weekly-challenge-074

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

        if array.count >= 2 {

            let midPoint:Int = Int(floor(Double(array.count) / 2))
            var (topKey, topVal) = findTopElement(array)

            if topVal < midPoint {
            	topKey = -1
            }

            print("List: \(list)")
            print("Majority Element: \(topKey)")
        }
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

func findTopElement(_ array:[String]) -> (Int, Int) {

    var dict = [Int: Int]()
    for i in 0..<array.count {
        let key:Int = Int(array[i])!
        if dict.isEmpty {
            dict[key] = 1
        }
        else {
            if dict[key] == nil {
                dict[key] = 1
            }
            else {
                dict[key]! += 1
            }
        }
    }

    let sortedDict = dict.sorted { $0.1 > $1.1 }

    return (sortedDict[0].key, sortedDict[0].value)
}
