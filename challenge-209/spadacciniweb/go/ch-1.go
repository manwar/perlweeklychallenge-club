/*
Task 1: Special Bit Characters
Submitted by: Mohammad S Anwar

You are given an array of binary bits that ends with 0.

Valid sequences in the bit string are:

[0] -decodes-to-> "a"
[1, 0] -> "b"
[1, 1] -> "c"
Write a script to print 1 if the last character is an “a” otherwise print 0.

Example 1
Input: @bits = (1, 0, 0)
Output: 1

The given array bits can be decoded as 2-bits character (10) followed by 1-bit character (0).

Example 2
Input: @bits = (1, 1, 1, 0)
Output: 0

Possible decode can be 2-bits character (11) followed by 2-bits character (10) i.e. the last character is not 1-bit character.
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
    if len(arrStr) < 1 {
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

    i := 0
    for i < len(arrInt)-1 {
        if arrInt[i] == 1 {
            i++
        }
        i++
    }

    if len(arrInt)-1 == i && arrInt[i] == 1 {
        log.Fatal("input error")
    }
    if len(arrInt) > i {
        fmt.Println("1");
    } else {
        fmt.Println("0");
    }
}
