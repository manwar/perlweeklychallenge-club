/*
Task 1: Count Even Digits Number
Submitted by: Mohammad Sajid Anwar

You are given a array of positive integers, @ints.

Write a script to find out how many integers have even number of digits.

Example 1
Input: @ints = (10, 1, 111, 24, 1000)
Output: 3

There are 3 integers having even digits i.e. 10, 24 and 1000.

Example 2
Input: @ints = (111, 1, 11111)
Output: 0

Example 3
Input: @ints = (2, 8, 1024, 256)
Output: 1
*/

package main

import (
    "fmt"
    "strconv"
)

func even_digits_number(arrInts []int) {
    even := 0
    for i := 0; i < len(arrInts); i++ {
        s := strconv.Itoa(arrInts[i])
        if len(s) % 2 == 0 {
            even++
        }
    }
    fmt.Printf("%v -> %d\n", arrInts, even)
}

func main() {
    arrInts := []int{10, 1, 111, 24, 1000}
    even_digits_number(arrInts)

    arrInts = []int{111, 1, 11111}
    even_digits_number(arrInts)

    arrInts = []int{2, 8, 1024, 256}
    even_digits_number(arrInts)
}
