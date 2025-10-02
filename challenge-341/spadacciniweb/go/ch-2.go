/*
Task 2: Reverse Prefix
Submitted by: Mohammad Sajid Anwar

You are given a string, $str and a character in the given string, $char.
Write a script to reverse the prefix upto the first occurrence of the given $char in the given string $str and return the new string.

Example 1
Input: $str = "programming", $char = "g"
Output: "gorpmming"

Reverse of prefix "prog" is "gorp".

Example 2
Input: $str = "hello", $char = "h"
Output: "hello"

Example 3
Input: $str = "abcdefghij", $char = "h"
Output: "hgfedcbaj"

Example 4
Input: $str = "reverse", $char = "s"
Output: "srevere"

Example 5
Input: $str = "perl", $char = "r"
Output: "repl"
*/

package main

import (
  "fmt"
)

func reverse_array(arr []rune) []rune {
    left := 0
    right := len(arr) - 1
    for left < right {
        arr[left], arr[right] = arr[right], arr[left]
        left++
        right--
    }
    return arr
}

func reverse_prefix(str string, chars string) {
    var str_new []rune
    var c rune

    for _, char := range chars {
        c = char
        break
    }

    for _, s := range str {
        str_new = append(str_new, s)
        if s == c {
            reverse_array(str_new)
            break
        }
    }

    for _, s := range str[len(str_new):] {
        str_new = append(str_new, s)
    }

    fmt.Printf("'%s' '%s' -> '%s'\n", string(str), string(chars), string(str_new))
}


func main() {
    str := "programming"
    char := "g"
    reverse_prefix( str, char )

    str = "hello"
    char = "h"
    reverse_prefix( str, char )

    str = "abcdefghij"
    char = "h"
    reverse_prefix( str, char )

    str = "reverse"
    char = "s"
    reverse_prefix( str, char )

    str = "perl"
    char = "r"
    reverse_prefix( str, char )
}
