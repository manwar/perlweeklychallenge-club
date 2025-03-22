/*
Task 1: Broken Keys
Submitted by: Mohammad Sajid Anwar

You have a broken keyboard which sometimes type a character more than once.
You are given a string and actual typed string.
Write a script to find out if the actual typed string is meant for the given string.

Example 1
Input: $name = "perl", $typed = "perrrl"
Output: true
Here "r" is pressed 3 times instead of 1 time.

Example 2
Input: $name = "raku", $typed = "rrakuuuu"
Output: true

Example 3
Input: $name = "python", $typed = "perl"
Output: false

Example 4
Input: $name = "coffeescript", $typed = "cofffeescccript"
Output: true
*/

package main

import (
    "fmt"
)

func broken_keyboard(name string, typed string) {
    freq := make(map[rune]int)
    for _, c := range name {
        freq[c]++
    }
    for _, c := range typed {
        _, ok := freq[c]
        if ok {
            freq[c]--
        }
    }
    broken := false
    for _, count := range freq {
        if count < 0 {
            broken = true
        }
    }
    fmt.Printf("name '%s' typed '%s' -> %t\n", name, typed, broken)
}


func main() {
    name := "perl"
    typed := "perrrl"
    broken_keyboard(name, typed)

    name = "raku"; typed = "rrakuuuu"
    broken_keyboard(name, typed)

    name = "python"; typed = "perl"
    broken_keyboard(name, typed)

    name = "coffeescript"; typed = "cofffeescccript"
    broken_keyboard(name, typed)
}
