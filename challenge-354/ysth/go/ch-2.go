package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK2

import (
    "errors"
    run "github.com/ysth/runweeklychallenge-go"
)

// rotate matrix cells right by k
func ShiftGrid(matrix [][]any, k int) ([][]any, error) {
    shiftedMatrix := make([][]any, 0, len(matrix))
    rows := len(matrix)
    // can't shift what isn't there (no rows or no columns)
    if rows > 0 && len(matrix[0]) > 0 {
        columns := len(matrix[0])
        for _, row := range matrix {
            if len(row) != columns {
                return shiftedMatrix, errors.New("matrix rows not all the same length")
            }
        }

        totalCells := columns * rows
        cells := make([]any, 0, totalCells)
        shift := k % totalCells
        shiftRows := shift / columns
        shiftColumns := shift % columns
        if shiftColumns > 0 {
            cells = append(cells, matrix[rows - shiftRows - 1][columns - shiftColumns:]...)
            for i := rows - shiftRows; i < rows; i++ {
                cells = append(cells, matrix[i]...)
            }
            for i := 0; i < rows - shiftRows - 1; i++ {
                cells = append(cells, matrix[i]...)
            }
            cells = append(cells, matrix[rows - shiftRows - 1][:columns - shiftColumns]...)
        } else {
            for i := rows - shiftRows; i < rows; i++ {
                cells = append(cells, matrix[i]...)
            }
            for i := 0; i < rows - shiftRows; i++ {
                cells = append(cells, matrix[i]...)
            }
        }

        for i := 0; i < rows; i++ {
            shiftedMatrix = append(shiftedMatrix, cells[i * columns:(i+1) * columns])
        }
    }

    return shiftedMatrix, nil
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) {
            result, err := ShiftGrid(run.AsSliceSlice(inputs, "matrix"), run.AsInt(inputs, "k"))
            if err != nil {
                return "", err
            } else {
                return run.JSONEncode(result), nil
            }
        },
        `{"matrix":[[1, 2, 3], [4, 5, 6], [7, 8, 9]],"k":1}`,
        `{
            "type":"object",
            "properties": {
                "matrix": {"type": "array", "items": {"type": "array"}},
                "k": {"type": "integer", "minimum": 1}
            },
            "required":["matrix","k"],
            "additionalProperties": false
        }`,
    )
}
