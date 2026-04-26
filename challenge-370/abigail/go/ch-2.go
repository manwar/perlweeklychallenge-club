package main

import (
    "fmt"
    "bufio"
    "os"
    "slices"
    "strings"
    "unicode/utf8"
)

func are_anagrams (str1 string, str2 string) bool {
    //
    // Turn the strings into arrays of runes (characters)
    //
    a_str1 := [] rune (str1)
    a_str2 := [] rune (str2)

    //
    // Not anagrams if not of equal length
    //
    if len (a_str1) != len (a_str2) {
        return false
    }

    //
    // Sort the arrays
    //
    slices . SortFunc (a_str1, func (a, b rune) int {
        if a < b {return -1}
        if a > b {return  1}
        return 0
    })

    slices . SortFunc (a_str2, func (a, b rune) int {
        if a < b {return -1}
        if a > b {return  1}
        return 0
    })

    //
    // Turn back into strings and compare. 
    //
    return string (a_str1) == string (a_str2)
}

//
// Helper function to do substr on runes
//
func substr (str string, start int, end int) string {
    runes := [] rune (str)
    if start < 0 {start += len (runes) + 1}
    if end   < 0 {end   += len (runes) + 1}
    return string (runes [start : end])
}


func can_scramble (input string, target string) bool {
    //
    // If strings are equal, we're done
    //
    if input == target {
        return true
    }

    //
    // Must be of equal length
    //
    if utf8 . RuneCountInString (input) != utf8 . RuneCountInString (target) {
        return false
    }

    //
    // Must be anagrams of each other
    //
    if !are_anagrams (input, target) {
        return false
    }

    //
    // Try splitting and recursing
    //
    for l := 1; l < utf8 . RuneCountInString (input); l ++ {
        m := utf8 . RuneCountInString (input) - l
        if can_scramble (substr (input, 0,  l), substr (target, 0,  l)) &&
           can_scramble (substr (input, l, -1), substr (target, l, -1)) ||
           can_scramble (substr (input, l, -1), substr (target, 0,  m)) &&
           can_scramble (substr (input, 0,  l), substr (target, m, -1)) {
            return true
        }
    }

    return false
}

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        text = strings . TrimSuffix (text, "\n")

        parts  := strings . Split (text, " ")
        input  := parts [0]
        target := parts [1]

        fmt . Println (can_scramble (input, target))
    }
}
