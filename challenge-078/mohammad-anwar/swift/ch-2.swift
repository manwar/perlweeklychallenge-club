import Foundation

/*

Perl Weekly Challenge - 078

Task #2: Left Rotation

https://perlweeklychallenge.org/blog/perl-weekly-challenge-078

*/

enum ParamError: Error {
    case missingSource
    case invalidSource
    case missingIndex
    case invalidIndex
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingSource
    }
    if paramCount <= 2 {
        throw ParamError.missingIndex
    }

    let source:String = CommandLine.arguments[1]
    let index:String  = CommandLine.arguments[2]
    if isValidList(source) {
        if isValidList(index) {
            let sourceArray = source.components(separatedBy: ", ")
            let indexArray  = index.components(separatedBy: ", ")

            var leftRotation = [[Int]]();
            for i in 0...indexArray.count-1 {
                var array      = [Int]();
                let _index:Int = Int(indexArray[i])!

                for j in _index...sourceArray.count-1 {
                    array.append(Int(sourceArray[j])!)
                }

                if _index > 0 {
                    for k in 0..._index-1 {
                        array.append(Int(sourceArray[k])!)
                    }
                }

                leftRotation.append(array)
            }

            print(leftRotation)
        }
        else {
            throw ParamError.invalidIndex
        }
    }
    else {
        throw ParamError.invalidSource
    }
}
catch ParamError.missingSource {
    print("Missing source.")
}
catch ParamError.missingIndex {
    print("Missing index.")
}
catch ParamError.invalidSource {
    print("Invalid source.")
}
catch ParamError.invalidIndex {
    print("Invalid index.")
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
