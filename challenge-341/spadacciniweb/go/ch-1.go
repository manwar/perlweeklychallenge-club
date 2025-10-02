/*
Task 1: Broken Keyboard
Submitted by: Mohammad Sajid Anwar

You are given a string containing English letters only and also you are given broken keys.
Write a script to return the total words in the given sentence can be typed completely.

Example 1
Input: $str = 'Hello World', @keys = ('d')
Output: 1

With broken key 'd', we can only type the word 'Hello'.

Example 2
Input: $str = 'apple banana cherry', @keys = ('a', 'e')
Output: 0

Example 3
Input: $str = 'Coding is fun', @keys = ()
Output: 3

No keys broken.

Example 4
Input: $str = 'The Weekly Challenge', @keys = ('a','b')
Output: 3

Example 5
Input: $str = 'Perl and Python', @keys = ('p')
Output: 1
*/

package main

import (
  "fmt"
  "strings"
)

func checkKeysInString(s string, bKeys []byte) bool {
    isInto := false
    for _, c := range[]byte(s) {
        for _, k := range bKeys {
            if c == k {
                isInto = true
            }
        }
    }
    return isInto
}

func convert_chars_to_bytes(keys []string) []byte {
    var bKeys []byte
    for _, x := range keys {
        bArr := []byte(strings.ToLower(x))
        bKeys = append(bKeys, bArr[0])
    }
    return bKeys
}


func broken_keyboard(str string, keys []string) {
    strs := strings.Split(str, " ")
    bKeys := convert_chars_to_bytes( keys )

    var okStrings []string
    for _, s := range strs {
        if !checkKeysInString(s, bKeys) {
            okStrings = append(okStrings, s)
        }
    }
    fmt.Printf("'%s' ('%s') -> %d\n", str, strings.Join(keys, "','"), len(okStrings))
}

func main() {
    str := strings.ToLower("Hello World")
    keys := []string{"d"}
    broken_keyboard(str, keys)

    str = "banana cherry"
    keys = []string{"a", "e"}
    broken_keyboard(str, keys)

    str = "Coding is fun"
    keys = []string{}
    broken_keyboard(str, keys)

    str = "The Weekly Challenge"
    keys = []string{"a","b"}
    broken_keyboard(str, keys)

    str = "Perl and Python"
    keys = []string{"p"}
    broken_keyboard(str, keys)
}
