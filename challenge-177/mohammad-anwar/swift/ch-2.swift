import Foundation

/*

Week 177:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-177

Task #2: Palindromic Prime Cyclops

    Write a script to generate first 20 Palindromic Prime Cyclops Numbers.

ACTION:

    $ swift ch-2.swift 20

*/

enum ParamError: Error {
    case missingNumber
    case invalidNumber
}
do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingNumber
    }

    let num:Int = Int(CommandLine.arguments[1])!
    if (num > 0) {
        var i:Int = 101;
        var j:Int = 0;
        while (j < num) {
            if    String(i).isPalindrome
               && i.isPrime
               && i.isCyclops {
                print(i)
                j = j + 1
            }
            i = i + 2
        }
    }
    else {
        throw ParamError.invalidNumber
    }
}
catch ParamError.missingNumber {
    print("Missing number.")
}
catch ParamError.invalidNumber {
    print("Invalid number.")
}
catch let error {
    print(error)
}

//
//
// Local extension

extension Int {
    var digits : [Int] {
        var result = [Int]()
        var remaining = abs(self)
        while remaining > 0 {
            result.insert(remaining % 10, at: 0)
            remaining /= 10
        }
        return result
    }

    var isPalindrome: Bool {
        return String(self) == String(String(self).reversed())
    }

    var isPrime: Bool {
        guard self >= 2     else { return false }
        guard self != 2     else { return true  }
        guard self % 2 != 0 else { return false }
        return !stride(from: 3, through: Int(sqrt(Double(self))), by: 2).contains { self % $0 == 0 }
    }

    var isCyclops: Bool {
        let d:[Int]   = self.digits
        let l:Int     = d.count;
        let m:Int     = Int((l - 1) / 2)
        let e:Int     = m + 1
        let fh:String = d[..<m].map{ String($0) }.joined(separator: "")
        let sh:String = d[e...].map{ String($0) }.joined(separator: "")

        if    l%2  == 0
           || d[m] != 0
           || fh.contains("0")
           || sh.contains("0") {
            return false
        }

        return true
    }
}

extension String {
    var isPalindrome: Bool {
        return self == String(self.reversed())
    }
}
