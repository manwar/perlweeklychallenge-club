import Foundation

/*
Perl Weekly Challenge - 063

Task #2: Rotate String

https://perlweeklychallenge.org/blog/perl-weekly-challenge-063
*/

enum ParamError: Error {
    case missingWord
    case invalidWord
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingWord
    }

    let word:String = CommandLine.arguments[1]

    if isValidWord(word) {
        let size:Int    = word.count;
        var temp:String = word
        var i:Int = 1
        var c:Int = 1

        while i <= size {
            let partA:String = String(temp.substring(to: i))
            let partB:String = String(temp.substring(from: i))
            temp = partB + partA
            print("[\(c)]: [\(temp)]")

            if temp == word {
                break
            }

            i = i + 1
            c = c + 1

            if i > size {
                i = 1
            }
        }

        print("Rotation: \(c)")
    }
    else {
        throw ParamError.invalidWord
    }
}
catch ParamError.missingWord {
    print("Missing word.")
}
catch ParamError.invalidWord {
    print("Invalid word.")
}
catch let error {
    print(error)
}

//
//
// Function

func isValidWord(_ word:String) -> Bool {

    let pattern = "^[xy]+$"
    let regex   = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    let range   = NSRange(location: 0, length: word.utf16.count)

    if regex.firstMatch(in: word, options: [], range: range) != nil {
        return true
    }
    else {
        return false
    }
}
