import Foundation

/*

Perl Weekly Challenge - 075

Task #2: Largest Rectangle Histogram

https://perlweeklychallenge.org/blog/perl-weekly-challenge-075

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

    let list:String = CommandLine.arguments[1]

    if isValidList(list) {
        let heights:[Int] = prepare(list)

        print(chart(heights))
        print("\nLargest Rectangle Histogram: " +
              String(largestRectangleHistogram(heights)))
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

func largestRectangleHistogram(_ heights:[Int]) -> Int {

    var max:Int = 0

    for i in 0...heights.count-1 {

        var left:Int  = 0
        var right:Int = 0

        if i > 0 {
            left = goLeft(i, heights)
        }

        if i <= heights.count-1 {
            right = goRight(i, heights)
        }

        let _heights:[Int] = Array(heights[i - left ... i + right])
        let size:Int       = _heights.min()! * _heights.count

        if size > max {
            max = size
        }

    }

    return max
}

func goLeft(_ i:Int, _ heights:[Int]) -> Int {

    let c:Int  = heights[i]
    var j:Int  = 0
    var _i:Int = i
    while _i > 0 {
        _i -= 1
        if heights[_i] < c {
            break
        }
        j += 1
    }

    return j
}

func goRight(_ i:Int, _ heights:[Int]) -> Int {

    let c:Int  = heights[i]
    var j:Int  = 0
    var _i:Int = i
    while _i < heights.count-1 {
        _i += 1
        if heights[_i] < c {
            break
        }
        j += 1
    }

    return j

}

func chart(_ heights:[Int]) -> String {

    let max:Int        = heights.max()!
    var chart:[String] = [String]()
    var row:Int        = 1
    var line:String    = ""
    var size:String    = " "

    for i in 1...max {

        var data:String = ""
        for j in 0...heights.count-1 {
            if row <= heights[j] {
                data += " #"
            }
            else {
                data += "  "
            }
        }

        row += 1
        chart.append("\(i)\(data)")

    }

    let histogram:String = (chart.reversed()).joined(separator: "\n")

    for i in 0...heights.count {
        line = line + "_ "
        if i < heights.count {
            size = size + " " + String(heights[i])
        }
    }

    var graph = [String]()
    graph.append(histogram)
    graph.append(line)
    graph.append(size)

    return graph.joined(separator: "\n")
}

func prepare(_ list:String) -> [Int] {

    var heights = [Int]()
    let array:[String] = list.components(separatedBy: ", ")
    for i in 0...array.count-1 {
        heights.append(Int(array[i])!)
    }

    return heights
}
