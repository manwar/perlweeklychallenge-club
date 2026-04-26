package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "regexp"
    // "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        //
        // Parse input. parts [0] will be the paragraph. 
        //              parts [1] will be the string with banned words
        //
        parts := strings . Split (strings . ToLower (text), "//")

        //
        // Extract the banned words, and put them in the map banned
        //
        banned := map [string] bool { }
        for _, ban := range regexp . MustCompile ("[[:alpha:]]+") .
                                     FindAllString (parts [1], -1) {
            banned [ban] = true
        }

        //
        // Extract the words from the paragraph (parts [0]), and, if
        // they aren't banned, tally them in the ok map
        //
        ok := map [string] int {"": 0}
        for _, word := range regexp . MustCompile ("[[:alpha:]]+") .
                                      FindAllString (parts [0], -1) {
            if !banned [word] {
                ok [word] += 1
            }
        }

        //
        // Find the most frequent occurring word
        //
        max := ""
        for word, count := range ok {
            if count > ok [max] {
                max = word
            }
        }

        fmt . Println (max)
    }
}
