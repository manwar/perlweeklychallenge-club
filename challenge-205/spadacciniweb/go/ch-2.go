/*
Task 2: Maximum XOR
Submitted by: Mohammad S Anwar

You are given an array of integers.
Write a script to find the highest value obtained by XORing any two distinct members of the array.

Example 1
Input: @array = (1,2,3,4,5,6,7)
Output: 7

The maximum result of 1 xor 6 = 7.

Example 2
Input: @array = (2,4,1,3)
Output: 7

The maximum result of 4 xor 3 = 7.

Example 3
Input: @array = (10,5,7,12,8)
Output: 15

The maximum result of 10 xor 5 = 15.
*/


package main

import (
    "fmt"
    "log"
    "os"
    "strconv"
    "gonum.org/v1/gonum/stat/combin"
)

func main() {
    arrStr := os.Args[1:]
    if (len(arrStr) < 1) {
        log.Fatal("input error")
    }

    arrInt := make([]int, len(arrStr))
    for i := 0; i <= len(arrStr)-1; i++ {
        value, err := strconv.Atoi(arrStr[i])
        if (err != nil) {
            log.Fatal(err)
        }
        arrInt[i] = value
    }

    var maxPointer *int
    var pair [2]int
    cs := combin.Combinations(len(arrInt), 2)
    for _, c := range cs {
        var temp = arrInt[c[0]] ^ arrInt[c[1]] 
        if maxPointer == nil || *maxPointer < temp {
            maxPointer = &temp
            pair[0] = arrInt[c[0]]
            pair[1] = arrInt[c[1]]
        }
    }

    fmt.Printf("Output: %d\n", *maxPointer)
    fmt.Printf("The maximum result of %d xor %d = %d\n", pair[0], pair[1], *maxPointer)

}
