import Foundation

/*

Perl Weekly Challenge - 073

Task #1: Min Sliding Window

https://perlweeklychallenge.org/blog/perl-weekly-challenge-073

*/

enum ParamError: Error {
    case missingList
    case missingSize
    case invalidList
    case invalidSize
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingList
    }

    if paramCount <= 2 {
        throw ParamError.missingSize
    }

    let list:String = CommandLine.arguments[1]
    let size:Int    = Int(CommandLine.arguments[2])!

    if isValidList(list) {
        let array = list.components(separatedBy: ", ")

        if size >= 2 && size <= array.count {
            var index:Int = 0;
            var minSlidingWindow = [Int]();
            while index + size - 1 < array.count {
                let start:Int = index
                let stop:Int  = index + size - 1
                let min:Int?  = findMin(array, start, stop)
                minSlidingWindow.append(min!)
                index += 1
            }

            print(array)
            print(minSlidingWindow)
        }
        else {
            throw ParamError.invalidSize
        }
    }
    else {
        throw ParamError.invalidList
    }
}
catch ParamError.missingList {
    print("Missing list.")
}
catch ParamError.missingSize {
    print("Missing size.")
}
catch ParamError.invalidList {
    print("Invalid list.")
}
catch ParamError.invalidSize {
    print("Invalid size.")
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

func findMin(_ array: [String], _ start:Int, _ stop:Int) -> Int {

    var window = [Int]()
    for i in start...stop {
        window.append(Int(array[i])!)
    }

    return window.min()!
}
