/*
Task 1: Jumping Letters
Submitted by: Mohammad S Anwar

You are given a word having alphabetic characters only, and a list of positive integers of the same length

Write a script to print the new word generated after jumping forward each letter in the given word by the integer in the list. The given list would have exactly the number as the total alphabets in the given word.

Example 1
Input: $word = 'Perl' and @jump = (2,22,19,9)
Output: Raku
'P' jumps 2 place forward and becomes 'R'.
'e' jumps 22 place forward and becomes 'a'. (jump is cyclic i.e. after 'z' you go back to 'a')
'r' jumps 19 place forward and becomes 'k'.
'l' jumps 9 place forward and becomes 'u'.

Example 2
Input: $word = 'Raku' and @jump = (24,4,7,17)
Output: 'Perl'
*/

package main

import (
    "fmt"
)

func tr_letter(c byte, jump int) string {
    ord := int(c)
    //return rune(ord)
    if (ord >= 97) {
        return string( ( ord - 97 + jump ) % 26 + 97 )
    } else {
        return string( ( ord - 65 + jump ) % 26 + 65 )
    }
}

func tr_word(word string, jump []int) string {
    new_word := ""
    for i := 0; i <= len(word)-1; i++ {
        new_word = new_word + tr_letter(byte(word[i]), jump[i])
    }
    return new_word
}

func main() {
    fmt.Println(tr_word("Perl", []int{2,22,19,9}))
    fmt.Println(tr_word("Raku", []int{24,4,7,17}))
}
