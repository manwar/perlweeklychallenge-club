/*
Task 1: Fun Sort
Submitted by: Mohammad S Anwar

You are given a list of positive integers.
Write a script to sort the all even integers first then all odds in ascending order.

Example 1
Input: @list = (1,2,3,4,5,6)
Output: (2,4,6,1,3,5)

Example 2
Input: @list = (1,2)
Output: (2,1)

Example 3
Input: @list = (1)
Output: (1)
*/

package main

import (
    "fmt"
    "log"
    "os"
    "strconv"
    "sort"
)

func main() {
    arrStr := os.Args[1:]
    if (len(arrStr) < 1) {
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

    listFun_even := make([]int, 0)
    listFun_odd := make([]int, 0)
    for i := 0; i <= len(arrInt)-1; i++ {
        if (arrInt[i] % 2 == 0) {
            listFun_even = append(listFun_even, arrInt[i])
        } else {
            listFun_odd = append(listFun_odd, arrInt[i])
        }
    }
    sort.Sort(sort.Reverse(sort.IntSlice(listFun_even)))
    sort.Sort(sort.Reverse(sort.IntSlice(listFun_odd)))
    listFun := append(listFun_even, listFun_odd...)
    fmt.Printf("Output: %v\n",listFun)
}
