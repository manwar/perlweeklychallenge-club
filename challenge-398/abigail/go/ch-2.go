package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    // "regexp"
    // "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        words := strings . Fields (text)
        diffs := make ([] string, len (words))
        for index, word := range (words) {
            runes  := [] rune (word)
            offset := runes [0] - 'a'
            for i, r := range (runes) {
                runes [i] = r - offset
            }
            diffs [index] = string (runes)
        }
        
        for index, diff := range (diffs) {
            next := (index               + 1) % len (diffs)
            prev := (index + len (diffs) - 1) % len (diffs)
            if diff != diffs [next] && diff != diffs [prev] {
                fmt . Printf ("%s\n", words [index])
                break
            }
        }
    }
}
