package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go
//

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "regexp"
)

func main () {
    var reader = bufio . NewReader (os. Stdin)
    var w      = [] rune {1, 3, 1, 7, 3, 9, 1}
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        //
        // Remove trailing newline
        //
        text = strings . TrimRight (text, "\n")

        //
        // Syntax check
        //
        match, _ := regexp . MatchString (
            "^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$", text)

        if !match {
            fmt . Print ("0\n")
            continue
        }

        //
        // Check sum
        //
        var check rune = 0
        for i, rune := range text {
            if rune <= '9' {
                rune -= '0'
            } else {
                rune -= 'A'
            }
            check += w [i] * rune
        }
        if check % 10 == 0 {
            fmt . Print ("1\n")
        } else {
            fmt . Print ("0\n")
        }
    }
}
