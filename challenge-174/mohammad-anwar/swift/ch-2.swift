import Foundation

/*

Week 174:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-174

Task #2: Permutation Ranking

    You are given a list of integers with no duplicates, e.g. [0, 1, 2].

    Write two functions, permutation2rank() which will take the list
    and determine its rank (starting at 0) in the set of possible
    permutations arranged in lexicographic order, and rank2permutation()
    which will take the list and a rank number and produce just that
    permutation.

ACTION:

    $ swift ch-2.swift "1,0,2" 1

*/

enum ParamError: Error {
    case missingList
    case missingRank
    case invalidList
    case invalidRank
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingList
    }

    if paramCount <= 2 {
        throw ParamError.missingRank
    }

    let list:String = CommandLine.arguments[1]
    let rank:Int    = Int(CommandLine.arguments[2])!

    if isValid(list) {
        if rank >= 0 {
            let arrays:[Int] = (list.components(separatedBy: ",")).map { Int($0)! }
            print(rank2permutation(arrays, rank))
        }
        else {
            throw ParamError.invalidRank
        }
    }
    else {
        throw ParamError.invalidList
    }
}
catch ParamError.missingList {
    print("Missing list.")
}
catch ParamError.missingRank {
    print("Missing rank.")
}
catch ParamError.invalidList {
    print("Invalid list.")
}
catch ParamError.invalidRank {
    print("Invalid rank.")
}
catch let error {
    print(error)
}

//
//
// Functions

func permutation2rank(_ arrays:[Int]) -> [[Int]] {
    return sortPermutations(arrays.allPermutations())
}

func rank2permutation(_ arrays:[Int], _ rank:Int) -> [Int] {
    let perms:[[Int]] = permutation2rank(arrays)
    return perms[rank]
}

func sortPermutations(_ perms: [[Int]]) -> [[Int]] {
    var strArrays:[String] = []
    for entry in perms {
        strArrays.append(entry.reduce("") { $0 + "\($1)" })
    }

    strArrays.sort()

    var intArrays:[[Int]] = []
    for entry in strArrays {
        intArrays.append(String(entry).compactMap { Int(String($0)) })
    }

    return intArrays
}

func isValid(_ list:String) -> Bool {
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

//
//
// Array extension borrowed from SO.
// https://stackoverflow.com/questions/30586711/order-array-of-objects-into-every-possible-sequence-in-swift

extension Array {
    private var decompose : (head: Element, tail: [Element])? {
        return (count > 0) ? (self[0], Array(self[1..<count])) : nil
    }

    private func between<T>(x: T, ys: [T]) -> [[T]] {
        if let (head, tail) = ys.decompose {
            return [[x] + ys] + between(x: x, ys: tail).map { [head] + $0 }
        } else {
            return [[x]]
        }
    }

    private func permutations<T>(xs: [T]) -> [[T]] {
        if let (head, tail) = xs.decompose {
            return permutations(xs: tail) >>= { permTail in
                self.between(x: head, ys: permTail)
            }
        } else {
            return [[]]
        }
    }

    func allPermutations() -> [[Element]] {
        return permutations(xs: self)
    }
}

infix operator >>=
func >>=<A, B>(xs: [A], f: (A) -> [B]) -> [B] {
    return xs.map(f).reduce([], +)
}
