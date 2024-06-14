/*
Task 2: B After A
Submitted by: Mohammad Sajid Anwar

You are given a string, $str.
Write a script to return true if there is at least one b, and no a appears after the first b.

Example 1
Input: $str = "aabb"
Output: true

Example 2
Input: $str = "abab"
Output: false

Example 3
Input: $str = "aaa"
Output: false

Example 4
Input: $str = "bbb"
Output: true
*/

package main

import (
    "fmt"
    s "strings"
)

func position (str string) {
    offset := s.Index(str, "b")
    res := 0
    
    if (offset >=0) {
        res = s.Index( str[offset+1:], "a");
    }

    if (res == -1) {
        fmt.Printf("%s -> %s\n", str, "true")
    } else {
        fmt.Printf("%s -> %s\n", str, "false")
    }
}

func main() {
    str := "aabb"
    position(str)

    str = "abab";
    position(str)

    str = "aaa"
    position(str)

    str = "bbb"
    position(str)
}

