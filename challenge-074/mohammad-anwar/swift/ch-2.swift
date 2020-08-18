import Foundation

/*

Perl Weekly Challenge - 074

Task #2: FNR Character

https://perlweeklychallenge.org/blog/perl-weekly-challenge-074

*/

enum ParamError: Error {
    case missingString
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingString
    }

    let string:String = CommandLine.arguments[1]
    let chars:[Character] = Array(String(string))

    var fnr = [Character]()
    if chars.count >= 2 {

        for i in 0..<chars.count {
            let s = String(string.prefix(i+1))
            if s.count == 1 {
                fnr.append(Character(s))
            }
            else {
                var found:Bool = false
                let characters = getCharacters(s)
                let revChars:[Character] = Array(String(s.reversed()))

                for i in 0..<revChars.count {
                    if characters[revChars[i]] == 1 {
                        fnr.append(revChars[i])
                        found = true
                        break
                    }
                }

                if found == false {
                    fnr.append("#")
                }
            }
        }

        print(chars)
        print(fnr)
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

func getCharacters(_ substring:String) -> [Character: Int] {

    let chars:[Character] = Array(String(substring))
    var characters = [Character: Int]()
    for i in 0..<chars.count {
        let char:Character = chars[i]
        if characters.isEmpty {
            characters[char] = 1
        }
        else {
            if characters[char] == nil {
                characters[char] = 1
            }
            else {
                characters[char]! += 1
            }
        }
    }

    return characters
}
