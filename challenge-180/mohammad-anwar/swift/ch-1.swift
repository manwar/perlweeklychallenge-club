import Foundation

/*

Week 180:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-180

Task #1: First Unique Character

    You are given a string, $s.

    Write a script to find out the first unique character in the
    given string and print its index (0-based).

ACTION:

    $ swift ch-1.swift 'Perl Weekly Challenge'
    $ swift ch-1.swift 'Long Live Perl'

*/

enum ParamError: Error {
    case missingString
}
do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingString
    }

    let str: String = CommandLine.arguments[1]
    var chars: [Character] = [Character]()
    var dicts = [Character:Int]()
    for var char: Character in Array(str) {
        if char == " " {
            continue
        }
        char = char.toLower()
        if let _: Int = dicts[char] {
            dicts[char]! += 1
        }
        else {
            chars.append(char)
            dicts[char] = 1
        }
    }

    var i:Int = 0;
    for char in chars {
        if dicts[char]! == 1 {
            print(i)
            break
        }
        i += 1
    }
}
catch ParamError.missingString {
    print("Missing string.")
}
catch let error {
    print(error)
}

extension Character {
    func toLower() -> Character {
        return String(self).lowercased().first!
    }
}
