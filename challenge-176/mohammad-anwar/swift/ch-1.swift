import Foundation

/*

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task #1: Permuted Multiples

    Write a script to find the smallest integer x such that x, 2x,
    3x, 4x, 5x and 6x are permuted multiples of each other.

ACTION:

    $ swift ch-1.swift

*/

var i:Int = 10
while true {
    var found:Bool = true
    for j in 2...6 {
        if !hasSameDigits(i, i * j) {
            found = false
            break
        }
    }

    if (found) {
        print(i)
        break
    }

    i = i + 1
}

//
//
// Functions

func hasSameDigits(_ m: Int, _ n: Int) -> Bool {
    var x:[Int] = m.digits
    var y:[Int] = n.digits

    x.sort()
    y.sort()

    return x == y
}

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
}
