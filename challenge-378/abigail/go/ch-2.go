package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        //
        // Turn string (without newline) into a slice of runes.
        // Iterate over the slice, turning the letters into digits
        //
        chars := [] rune (strings . TrimSuffix (text, "\n"))
        for i, ch := range (chars) {
            if ch >= 'a' && ch <= 'j' {
                chars [i] -= 'a'
                chars [i] += '0'
            }
        }

        //
        // Turn the slice of runes back into a string, then split on
        // whitespace. Turn each part into an integer
        //
        numbers := strings . Fields (string (chars))
        n1,  _  := strconv . Atoi (numbers [0])
        n2,  _  := strconv . Atoi (numbers [1])
        sum, _  := strconv . Atoi (numbers [2])

        //
        // Check sum
        //
        if n1 + n2 == sum {
            fmt . Println ("true")
        } else {
            fmt . Println ("false")
        }
    }
}
