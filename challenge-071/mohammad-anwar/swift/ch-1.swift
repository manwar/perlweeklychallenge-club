import Foundation

/*
Perl Weekly Challenge - 071

Task #1: Peak Elements

https://perlweeklychallenge.org/blog/perl-weekly-challenge-071
*/

enum ParamError: Error {
    case missingSize
    case invalidSize
}

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingSize
    }

    let size:Int = Int(CommandLine.arguments[1])!

    if size <= 1 {
        throw ParamError.invalidSize
    }

    let array:[Int] = get_random_array(size)
    var peakElements:[Int] = []

    if array[0] > array[1] {
        peakElements.append(array[0])
    }

    for i in 1...array.count-2 {
        if array[i] > array[i-1] && array[i] > array[i+1] {
            peakElements.append(array[i])
        }
    }

    if array[array.count - 2] < array[array.count - 1] {
        peakElements.append(array[array.count - 1])
    }

    print(array);
    print(peakElements);
}
catch ParamError.missingSize {
    print("Missing size.")
}
catch ParamError.invalidSize {
    print("Invalid size.")
}
catch let error {
    print(error)
}

//
// Function

func get_random_array(_ size:Int) -> [Int] {

    let minValue:Int = 1
    let maxValue:Int = 50
    var _size:Int    = size

    var elements:Dictionary<Int, Int> = [:]
    while _size >= 1 {
        let e:Int = Int.random(in: minValue..<maxValue)
        if elements[e] != 1 {
            elements[e] = 1
            _size = _size - 1
        }
    }

    return Array(elements.keys)
}
