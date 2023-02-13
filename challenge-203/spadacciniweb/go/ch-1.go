/*
Task 1: Special Quadruplets
Submitted by: Mohammad S Anwar

You are given an array of integers.
Write a script to find out the total special quadruplets for the given array.

Special Quadruplets are such that satisfies the following 2 rules.
1) nums[a] + nums[b] + nums[c] == nums[d]
2) a < b < c < d


Example 1
Input: @nums = (1,2,3,6)
Output: 1 
Since the only special quadruplets found is $nums[0] + $nums[1] + $nums[2] == $nums[3].

Example 2
Input: @nums = (1,1,1,3,5)
Output: 4
$nums[0] + $nums[1] + $nums[2] == $nums[3]
$nums[0] + $nums[1] + $nums[3] == $nums[4]
$nums[0] + $nums[2] + $nums[3] == $nums[4]
$nums[1] + $nums[2] + $nums[3] == $nums[4]

Example 3
Input: @nums = (3,3,6,4,5)
Output: 0
*/

package main

import (
    "fmt"
    "log"
    "os"
    "strconv"
)

type quad struct {
    i, j, k, z int
}

func main() {
    arrStr := os.Args[1:]
    if (len(arrStr) < 4) {
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

    quadruplets := make([]quad, 0)
    for i := 0; i <= len(arrInt)-4; i++ {
        for j := i+1; j <= len(arrInt)-3; j++ {
            for k := j+1; k <= len(arrInt)-2; k++ {
                for z := k+1; z <= len(arrInt)-1; z++ {
                    if arrInt[i] + arrInt[j] + arrInt[k] == arrInt[z] {
                        quadruplets = append(quadruplets, quad{i, j, k, z})
                    }
                }
            }
        }
    }

    fmt.Println(len(quadruplets))
}
