/*
Task 1: Monotonic Array
Submitted by: Mohammad S Anwar

You are given an array of integers.
Write a script to find out if the given array is Monotonic. Print 1 if it is otherwise 0.

    An array is Monotonic if it is either monotone increasing or decreasing.

Monotone increasing: for i <= j , nums[i] <= nums[j]
Monotone decreasing: for i <= j , nums[i] >= nums[j]

Example 1
Input: @nums = (1,2,2,3)
Output: 1

Example 2
Input: @nums (1,3,2)
Output: 0

Example 3
Input: @nums = (6,5,5,4)
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
    if (len(arrStr) < 2) {
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

    var monotone_inc = true
    var monotone_dec = true
    for i := 1; i <= len(arrInt)-1 ; i++ {
        if monotone_inc && arrInt[i] < arrInt[i-1] {
            monotone_inc = false
        }
        if monotone_dec && arrInt[i] > arrInt[i-1] {
            monotone_dec = false
        }
        if !monotone_inc && !monotone_dec {
            break
        }
    }

    var output = 0
    if monotone_inc || monotone_dec {
        output = 1
    }
    fmt.Println("Output:", output)
}
