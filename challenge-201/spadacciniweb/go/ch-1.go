/*
Task 1: Missing Numbers
Submitted by: Mohammad S Anwar

You are given an array of unique numbers.
Write a script to find out all missing numbers in the range 0..$n where $n is the array size.

Example 1
Input: @array = (0,1,3)
Output: 2

The array size i.e. total element count is 3, so the range is 0..3.
The missing number is 2 in the given array.
 
Example 2
Input: @array = (0,1)
Output: 2

The array size is 2, therefore the range is 0..2.
The missing number is 2.
*/

package main

import (
    "fmt"
    "os"
    "strconv"
)

func main() {
    arrStr := os.Args[1:]
    arrInt := make([]int, 0)
    for i := 0; i <= len(arrStr)-1; i++ {
        value, _ := strconv.Atoi(arrStr[i])
        arrInt = append(arrInt, value)
    }

    missing := make([]int, 0)
    for i := 0; i <= len(arrInt) ; i++ {
        isPresent := contains(arrInt, i)
        if !isPresent {
            missing = append(missing, i)
        }
    }

    if len(missing) > 1 {
        fmt.Print("The missing are:")
    } else {
        fmt.Print("The missing is:")
    }

    for _, value := range missing {
        fmt.Printf(" %d", value)
    }

    fmt.Println()
}

func contains(a []int, e int) bool {
    for _, v := range a {
        if v == e {
            return true
        }
    }
    return false
}
