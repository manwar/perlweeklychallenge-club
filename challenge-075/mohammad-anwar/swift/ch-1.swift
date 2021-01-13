import Foundation

/*

Perl Weekly Challenge - 075

Task #1: Coins Sum

https://perlweeklychallenge.org/blog/perl-weekly-challenge-075

*/

enum ParamError: Error {
    case missingList
    case missingSum
    case invalidList
    case invalidSum
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingList
    }

    let list:String = CommandLine.arguments[1]

    if isValidList(list) {

        let sum:Int = Int(CommandLine.arguments[2])!
        if sum > 0 {
            let coins = list.components(separatedBy: ", ")
            let size:Int = coins.count - 1

            if size >= 1 {

                var matrix = [[Int]]()

                // Sum of 0 can be achieved in one possible way.
                for _ in 0...size {
                    var row = [Int]()
                    row.append(1)
                    matrix.append(row)
                }

                for i in 0...size {

                    for j in 1...sum {

                        var includeCurrent:Int = 0
                        var excludeCurrent:Int = 0
                        let currentCoin:Int    = Int(coins[i])!

                        if currentCoin <= j {
                            includeCurrent = matrix[i][j - currentCoin]
                        }

                        if i > 0 {
                            excludeCurrent = matrix[i - 1][j]
                        }

                        matrix[i].append(includeCurrent + excludeCurrent)
                    }
                }

                print(matrix[size][sum])
            }
        }
        else {
            throw ParamError.invalidSum
        }
    }
    else {
        throw ParamError.invalidList
    }
}
catch ParamError.missingList {
    print("Missing list.")
}
catch ParamError.missingSum {
    print("Missinng sum.")
}
catch ParamError.invalidList {
    print("Invalid list.")
}
catch ParamError.invalidSum {
    print("Invalid Sum.")
}
catch let error {
    print(error)
}

//
//
// Function

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
