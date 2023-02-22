/*
Task 1: Third Highest
Submitted by: Mohammad S Anwar

You are given an array of integers.
Write a script to find out the Third Highest if found otherwise return the maximum.

Example 1
Input: @array = (5,3,4)
Output: 3

First highest is 5. Second highest is 4. Third highest is 3.

Example 2
Input: @array = (5,6)
Output: 6

First highest is 6. Second highest is 5. Third highest is missing, so maximum is returned.

Example 3
Input: @array = (5,4,4,3)
Output: 3

First highest is 5. Second highest is 4. Third highest is 3.
*/

package main 

import (
    "fmt"
    "log"
    "os"
    "sort"
    "strconv"
)

func main() {
    arrStr := os.Args[1:]
    if (len(arrStr) < 1) {
        log.Fatal("input error")
    }

    m := make(map[int]bool)
    for i := 0; i <= len(arrStr)-1; i++ {
        value, err := strconv.Atoi(arrStr[i])
        if (err != nil) {
            log.Fatal(err)
        }
        _, ok := m[value]; if !ok {
            m[value] = true
        }
    }

    arrInt := make([]int, len(m))
    i := 0
    for k := range m {
        arrInt[i] = k
        i++
    }

    sort.Sort(sort.Reverse(sort.IntSlice(arrInt)))
    if len(arrInt) >= 3 {
        fmt.Println("Output:", arrInt[2])
    } else {
        fmt.Println("arrInt:", arrInt[0])
    }
}
