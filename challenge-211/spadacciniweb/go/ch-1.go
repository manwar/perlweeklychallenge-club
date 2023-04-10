/*
Task 1: Toeplitz Matrix
Submitted by: Mohammad S Anwar

You are given a matrix m x n.
Write a script to find out if the given matrix is Toeplitz Matrix.
A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.


Example 1
Input: @matrix = [ [4, 3, 2, 1],
                   [5, 4, 3, 2],
                   [6, 5, 4, 3],
                 ]
Output: true

Example 2
Input: @matrix = [ [1, 2, 3],
                   [3, 2, 1],
                 ]
Output: false
*/

package main

import (
    "fmt"
)

func check_toeplitz(m [][]int) bool {
    rows := len(m)
    cols := len(m[0])
    var dimens int = rows
    if (cols < rows) {
        dimens = cols
    }
    val := m[0][0]
    for i := 0; i < dimens; i++ {
        if m[i][i] != val {
            return false
        }
    }
    return true
}

func main() {
    matrix1 := [][]int{
      {4, 3, 2, 1},
      {5, 4, 3, 2},
      {6, 5, 4, 3},
    }
    fmt.Println(check_toeplitz(matrix1))

    matrix2 := [][]int{
      {1, 2, 3},
      {3, 2, 1},
    }
    fmt.Println(check_toeplitz(matrix2))
}
