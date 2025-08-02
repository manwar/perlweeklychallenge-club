/*
Task 2: Sum of Values
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @int and an integer $k.

Write a script to find the sum of values whose index binary representation has exactly $k number of 1-bit set.

Example 1
Input: @ints = (2, 5, 9, 11, 3), $k = 1
Output: 17

Binary representation of index 0 = 0
Binary representation of index 1 = 1
Binary representation of index 2 = 10
Binary representation of index 3 = 11
Binary representation of index 4 = 100

So the indices 1, 2 and 4 have total one 1-bit sets.
Therefore the sum, $ints[1] + $ints[2] + $ints[3] = 17

Example 2
Input: @ints = (2, 5, 9, 11, 3), $k = 2
Output: 11

Example 3
Input: @ints = (2, 5, 9, 11, 3), $k = 0
Output: 2
*/

package main

import (
    "fmt"
    "strings"
)

func sum_of_value(arrInts []int, k int) {
    sum := 0
    for i := 0; i < len(arrInts); i++ {
        bin := fmt.Sprintf("%b", i)
        s := string(bin[:])
        if strings.Count(s, "1") == k {
            sum += arrInts[i]
        }
    }
    fmt.Printf("%v %d -> %d\n", arrInts, k, sum)
}

func main() {
    arrInts := []int{2, 5, 9, 11, 3}
    k := 1
    sum_of_value(arrInts, k)

    arrInts = []int{2, 5, 9, 11, 3}
    k = 2
    sum_of_value(arrInts, k)

    arrInts = []int{2, 5, 9, 11, 3}
    k = 0
    sum_of_value(arrInts, k)
}
