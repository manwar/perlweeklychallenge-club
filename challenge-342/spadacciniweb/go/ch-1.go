/*
Task 1: Balance String
Submitted by: Mohammad Sajid Anwar

You are given a string made up of lowercase English letters and digits only.
Write a script to format the give string where no letter is followed by another letter and no digit is followed by another digit. If there are multiple valid rearrangements, always return the lexicographically smallest one. Return empty string if it is impossible to format the string.

Example 1
Input: $str = "a0b1c2"
Output: "0a1b2c"

Example 2
Input: $str = "abc12"
Output: "a1b2c"

Example 3
Input: $str = "0a2b1c3"
Output: "0a1b2c3"

Example 4
Input: $str = "1a23"
Output: ""

Example 5
Input: $str = "ab123"
Output: "1a2b3"
*/

package main

import (
  "fmt"
  "regexp"
  "sort"
)

func balance_string(str string) {
    balance_string := ""

    re := regexp.MustCompile(`[a-zA-Z]`)
    letters := re.FindAllString(str, -1)
    sort.Strings(letters[:])

    re = regexp.MustCompile(`\d`)
    figures := re.FindAllString(str, -1)
    sort.Strings(figures[:])

    if (len(letters) - len(figures) <= 1) && (len(letters) - len(figures) >= 0) || (len(figures) - len(letters) <= 1) && (len(figures) - len(letters) >= 0) {
        if (len(letters) > len(figures)) {
            balance_string += letters[0]
            letters = letters[1:]
        }
        for range len(letters) {
            balance_string += figures[0]
            figures = figures[1:]
            balance_string += letters[0]
            letters = letters[1:]
            
        }
        if len(figures) > 0 {
            balance_string += figures[0]
        }
    }

    fmt.Printf("'%s' -> '%s'\n", str, balance_string)
}

func main() {
    str := "a0b1c2"
    balance_string(str)

    str = "abc12"
    balance_string(str)

    str = "0a2b1c3"
    balance_string(str)

    str = "1a23"
    balance_string(str)

    str = "ab123"
    balance_string(str)
}
