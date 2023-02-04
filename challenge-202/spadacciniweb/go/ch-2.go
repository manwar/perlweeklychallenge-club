/*
Task 2: Widest Valley
Submitted by: E. Choroba

Given a profile as a list of altitudes, return the leftmost widest valley. A valley is defined as a subarray of the profile consisting of two parts: the first part is non-increasing and the second part is non-decreasing. Either part can be empty.

Example 1
Input: 1, 5, 5, 2, 8
Output: 5, 5, 2, 8

Example 2
Input: 2, 6, 8, 5
Output: 2, 6, 8

Example 3
Input: 9, 8, 13, 13, 2, 2, 15, 17
Output: 13, 13, 2, 2, 15, 17

Example 4
Input: 2, 1, 2, 1, 3
Output: 2, 1, 2

Example 5
Input: 1, 3, 3, 2, 1, 2, 3, 3, 2
Output: 3, 3, 2, 1, 2, 3, 3
*/

package main

import (
    "fmt"
    "log"
    "os"
    "strconv"
    "strings"
)

type subvalley struct {
    w, i int
    elements []int
}

func main() {
    arrStr := os.Args[1:]
    arrInt := make([]int, 0)
    for i := 0; i <= len(arrStr)-1; i++ {
        value, err := strconv.Atoi(arrStr[i])
        if (err != nil) {
            log.Fatal(err)
        }
        arrInt = append(arrInt, value)
    }

    valleys := make([]subvalley, 0)
    for min := 0; min <= len(arrInt)-1; min++ {
        for max := len(arrInt)-1; max >= min; max-- {
            subarray := arrInt[min:max+1]
            if checkValley(subarray) {
                valleys = append(valleys, subvalley{len(subarray), min, subarray})
            }
        }
    }

    widest := 0
    leftest := len(arrInt)
    sv := make([]int, 0)
    for i := 0; i <= len(valleys)-1; i++ {
        arrMix := valleys[i]
        if arrMix.w > widest ||
           arrMix.w == widest && leftest > arrMix.i {
            widest = arrMix.w
            leftest = arrMix.i
            sv = arrMix.elements
        }
    }

    fmt.Println( strings.Trim(strings.Replace(fmt.Sprint(sv), " ", ", ", -1), "[]") )
}

func checkValley(arrInt []int) bool {
    index_left, index_right := 0, len(arrInt)-1

    for i := 0; i <= len(arrInt)-1 ; i++ {
        if arrInt[index_left] < arrInt[i] {
            break
        }
        index_left = i
    }
    for i := len(arrInt)-2; i >= index_left ; i-- {
        if arrInt[index_right] < arrInt[i] {
            break
        }
        index_right = i
    }
    if index_right == index_left {
        return true
    } else {
        return false
    }
}
