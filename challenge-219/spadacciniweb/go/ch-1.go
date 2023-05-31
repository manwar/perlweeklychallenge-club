/*
Task 1: Sorted Squares
Submitted by: Mohammad S Anwar

You are given a list of numbers.

Write a script to square each number in the list and return the sorted list, increasing order.
Example 1

Input: @list = (-2, -1, 0, 3, 4)
Output: (0, 1, 4, 9, 16)

Example 2

Input: @list = (5, -4, -1, 3, 6)
Output: (1, 9, 16, 25, 36)
*/

package main

import (
    "fmt"
    "log"
    "os"
    "strconv"
    "math"
    "sort"
)

func main() {
    arrStr := os.Args[1:]
    if (len(arrStr) < 1) {
        log.Fatal("input error")
    }

    arrFloat := make([]float64, 0)
    for i := 0; i <= len(arrStr)-1; i++ {
        value, err := strconv.ParseFloat(arrStr[i], 8)
        if (err != nil) {
            log.Fatal(err)
        }
        arrFloat = append(arrFloat, value)
    }

    arrSquare := make([]int, 0)
    for i := 0; i <= len(arrFloat)-1; i++ {
        arrSquare = append(arrSquare, int(math.Pow(arrFloat[i], 2)))
    }
    sort.Sort(sort.IntSlice(arrSquare))
    fmt.Printf("Output: %v\n",arrSquare)
}
