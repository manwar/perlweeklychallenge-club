/*
Task 1: Consecutive Odds
You are given an array of integers.
Write a script to print 1 if there are THREE consecutive odds in the given array otherwise print 0.

Example 1
Input: @array = (1,5,3,6)
Output: 1

Example 2
Input: @array = (2,6,3,5)
Output: 0

Example 3
Input: @array = (1,2,3,4)
Output: 0

Example 4
Input: @array = (2,3,5,7)
Output: 1
*/

package main

import (
    "fmt"
    "log"
    "os"
    "strconv"
)

func main() {
    arrStr := os.Args[1:]
    if (len(arrStr) < 3) {
        log.Fatal("input error")
    }

    arrInt := make([]int, 0)
    for i := 0; i <= len(arrStr)-1; i++ {
        value, err := strconv.Atoi(arrStr[i])
        if (err != nil) {
            log.Fatal(err)
        }
        arrInt = append(arrInt, value)
    }

    var output = 0
    for i := 0; i <= len(arrInt)-3 ; i++ {
        if (isOdd(arrInt[i]) &&
            isOdd(arrInt[i+1]) &&
            isOdd(arrInt[i+2]) ) {
            output = 1
            break;
        }
    }
    
    fmt.Println("Output:", output)
}

func isOdd(a int) bool {
    if (a % 2 == 1) {
        return true
    }
    return false
}
