/*
Task 1: Lucky Integer
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.
Write a script to find the lucky integer if found otherwise return -1. If there are more than one then return the largest.

    A lucky integer is an integer that has a frequency in the array equal to its value.

Example 1
Input: @ints = (2, 2, 3, 4)
Output: 2

Example 2
Input: @ints = (1, 2, 2, 3, 3, 3)
Output: 3

Example 3
Input: @ints = (1, 1, 1, 3)
Output: -1
*/

package main

import (
  "fmt"
)

func max(lucky []int) int {
    max := lucky[0]
    for _, v := range lucky {
        if (v > max) {
            max = v
        }
    }
    return max
}

func lucky_integer(ints []int) {
    freq := make(map[int]int)
    for _, num := range ints {
        freq[num] = freq[num]+1
    }
    var lucky []int
    for key, x := range freq {
        if key == x {
            lucky = append(lucky, x)
        }
    }
    lucky = append(lucky, -1)

    fmt.Printf("ints %v: %d\n", ints, max(lucky))
}

func main() {
    ints := []int{2, 2, 3, 4}
    lucky_integer(ints)

    ints = []int{1, 2, 2, 3, 3, 3}
    lucky_integer(ints)

    ints = []int{1, 1, 1, 3}
    lucky_integer(ints)
}
