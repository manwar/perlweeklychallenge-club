import Foundation

/*

Perl Weekly Challenge - 073

Task #2: Smallest Neighbour

https://perlweeklychallenge.org/blog/perl-weekly-challenge-073

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

    var list:String = CommandLine.arguments[1]

    if isValidList(list) {
            list = list.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
            let array = list.components(separatedBy: ",")

            var smallestNeighbour = [Int]()
            smallestNeighbour.append(0)

            for i in 1..<array.count {
                let limit:Int = i - 1
                let min:Int?  = findMin(array, limit, Int(array[i])!)
                smallestNeighbour.append(min!)
            }

            print(array)
            print(smallestNeighbour)
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

    let pattern = "^[\\s?\\-?\\d\\,?\\s?]+$"
    let regex   = try! NSRegularExpression(pattern: pattern)
    let range   = NSRange(location: 0, length: list.utf16.count)

    if regex.firstMatch(in: list, options: [], range: range) != nil {
        return true
    }
    else {
        return false
    }
}

func findMin(_ array: [String], _ limit:Int, _ current:Int) -> Int {

    var window = [Int]()
    for i in 0...limit {
        window.append(Int(array[i])!)
    }

    let min:Int = window.min()!
    if min < current {
        return min
    }
    else {
        return 0
    }
}
