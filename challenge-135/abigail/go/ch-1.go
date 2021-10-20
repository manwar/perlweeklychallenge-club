package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
    "bufio"
    "os"
    "strings"
)

func main () {
    var reader = bufio . NewReader (os. Stdin)
  main_loop:
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        //
        // Get rid of newline
        //
        text = strings . TrimRight (text, "\n")

        //
        // Remove leading sign, if any
        //
        if (text [0:1] == "-" || text [0:1] == "+") {
            text = text [1:]
        }

        //
        // Check if each character is a number
        //
        for _, rune := range text {
            if rune < '0' || rune > '9' {
                fmt . Print ("not an integer\n")
                continue main_loop
            }
        }
        
        //
        // Check for even length
        //
        if len (text) % 2 == 0 {
            fmt . Print ("even number of digits\n")
            continue main_loop
        }

        //
        // Long enough?
        //
        if len (text) < 3 {
            fmt . Print ("too short\n")
            continue main_loop
        }

        fmt . Printf ("%s\n", text [(len (text) - 3) / 2 :
                                    (len (text) + 3) / 2])
    }
}
