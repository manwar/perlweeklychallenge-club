/*
Task 1: Element Digit Sum
Submitted by: Mohammad Sajid Anwar

You are given an array of integers, @ints.
Write a script to evaluate the absolute difference between element and digit sum of the given array.

Example 1
Input: @ints = (1,2,3,45)
Output: 36

Element Sum: 1 + 2 + 3 + 45 = 51
Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
Absolute Difference: | 51 - 15 | = 36

Example 2
Input: @ints = (1,12,3)
Output: 9

Element Sum: 1 + 12 + 3 = 16
Digit Sum: 1 + 1 + 2 + 3 = 7
Absolute Difference: | 16 - 7 | = 9

Example 3
Input: @ints = (1,2,3,4)
Output: 0

Element Sum: 1 + 2 + 3 + 4 = 10
Digit Sum: 1 + 2 + 3 + 4 = 10
Absolute Difference: | 10 - 10 | = 0

Example 4
Input: @ints = (236, 416, 336, 350)
Output: 1296
*/

package main

import (
    "fmt"
    "strconv"
)

func absDiffInt(x, y int) int {
   if x < y {
      return y - x
   }
   return x - y
}

func absolute_difference(ints []int) {
    sum_ints := 0
    sum_digits := 0
    for i := 0; i < len(ints); i++ {
        sum_ints += ints[i]
        str := strconv.Itoa(ints[i])
        for p, _ := range str {
            i, e := strconv.Atoi(string(str[p]))
            if e == nil {
                sum_digits += i
            }
        }
    }

    s := fmt.Sprint(ints)
    fmt.Printf("%s -> %d\n",
        s,
        absDiffInt(sum_ints, sum_digits))
}

func main() {
    ints := []int{1,2,3,45}
    absolute_difference(ints)

    ints = []int{1,12,3}
    absolute_difference(ints)

    ints = []int{1,2,3,4}
    absolute_difference(ints)

    ints = []int{236, 416, 336, 350}
    absolute_difference(ints)
}
