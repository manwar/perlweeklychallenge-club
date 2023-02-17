/*
Task 2: Reshape Matrix
Submitted by: Mohammad S Anwar

You are given a matrix (m x n) and two integers (r) and (c).

Write a script to reshape the given matrix in form (r x c) with the original value in the given matrix. If you can’t reshape print 0.

Example 1
Input: [ 1 2 ]
       [ 3 4 ]

       $matrix = [ [ 1, 2 ], [ 3, 4 ] ]
       $r = 1
       $c = 4

Output: [ 1 2 3 4 ]

Example 2
Input: [ 1 2 3 ]
       [ 4 5 6 ]

       $matrix = [ [ 1, 2, 3 ] , [ 4, 5, 6 ] ]
       $r = 3
       $c = 2

Output: [ [ 1, 2 ], [ 3, 4 ], [ 5, 6 ] ]
        [ 1 2 ]
        [ 3 4 ]
        [ 5 6 ]

Example 3
Input: [ 1 2 ]
       $matrix = [ [ 1, 2 ] ]
       $r = 3
       $c = 2

Output: 0
*/

package main

import (
    "fmt"
)

func main() {
    m := [][]int{[]int{1,2}, []int{3, 4}}
    matrixStep(m, 1, 4)

    m = [][]int{[]int{1,2,3}, []int{4,5,6}}
    matrixStep(m, 3, 2)

    m = [][]int{[]int{1,2}}
    matrixStep(m, 3, 2)
}

func matrixStep(mat [][]int, r int, c int) {
    fmt.Println("Input matrix: ")
    matrixPrint(mat,0)
    fmt.Printf("reshaping %dx%d:\n", r, c)
    reshaped,errorCode := matrixReshape(mat, r, c)
    matrixPrint(reshaped,errorCode)
    fmt.Println()
}

func matrixReshape(mat [][]int, r int, c int) ([][]int , int ) {
    var rows, cols = len(mat), len(mat[0])
    if rows * cols != r * c {
        return mat, 1
    } else {
        var q = make([]int, 0)
        for _, i := range(mat) {
            for _, j := range(i) {
                q = append(q, j)
            }
        }
        var idx = 0
        var ans = make([][]int, r)
        for i := 0; i < r; i ++ {
            ans[i] = make([]int, c)
            for j := 0; j < c; j ++ {
                ans[i][j] = q[idx]
                idx ++
            }
        }
        return ans, 0
    }
}

func matrixPrint(mat [][]int, errorCode int) {
    if errorCode != 0 {
        fmt.Println(0)
    } else {
        var rows, cols = len(mat), len(mat[0])
        for i := 0; i < rows; i++ {
            for j := 0; j < cols; j++ {
                fmt.Printf("%d ", mat[i][j])
            }
            fmt.Println()
        }
    }
}
