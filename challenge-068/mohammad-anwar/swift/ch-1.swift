import Foundation

/*
Perl Weekly Challenge - 068

Task #1: Zero Matrix

https://perlweeklychallenge.org/blog/perl-weekly-challenge-068
*/

enum ParamError: Error {
    case missingRowsandCols
    case missingCols
}

var rows:Int = 0
var cols:Int = 0
var matrix   = [[Int]]()

do {
    let paramCount:Int = Int(CommandLine.argc)

    if paramCount <= 1 {
        throw ParamError.missingRowsandCols
    }
    else if paramCount <= 2 {
        throw ParamError.missingCols
    }

    rows   = Int(CommandLine.arguments[1])!
    cols   = Int(CommandLine.arguments[2])!
    matrix = generateMatrix(rows, cols)
}
catch ParamError.missingRowsandCols {
    rows   = 3
    cols   = 3
    matrix = [[1, 0, 1], [1, 1, 1], [1, 0, 1]]
}
catch ParamError.missingCols {
    rows   = Int(CommandLine.arguments[1])!
    cols   = 3
    matrix = generateMatrix(rows, cols)
}

var zeroMatrix:[[Int]] = initZeroMatrix(rows, cols)
for r in 0..<rows {
    for c in 0..<cols {
        if matrix[r][c] == 0 {
            // make zero row
            for i in 0..<cols {
                zeroMatrix[r][i] = 0
            }
            // make zero col
            for j in 0..<rows {
                zeroMatrix[j][c] = 0
            }
        }
    }
}

print(zeroMatrix)


// Functions

func generateMatrix(_ rows:Int, _ cols:Int) -> [[Int]] {
    var matrix = [[Int]]()
    for _ in 1...rows {
        var row:[Int] = []
        for _ in 1...cols {
            row.append(Int.random(in: 0..<2))
        }
        matrix.append(row)
    }

    return matrix
}

func initZeroMatrix(_ rows:Int, _ cols:Int) -> [[Int]] {
    var matrix = [[Int]]()
    for _ in 1...rows {
        var row:[Int] = []
        for _ in 1...cols {
            row.append(1)
        }
        matrix.append(row)
    }

    return matrix
}
