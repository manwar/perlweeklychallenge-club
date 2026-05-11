package main

import (
    "fmt"
    "bufio"
    "os"
    S "strings"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        
        text     = S . ReplaceAll (text, "\"", "")  // Remove quotes
        text     = S . ReplaceAll (text, "\n", "")  // Remove newline
        spaces  := S . Count      (text, " ")       // Count spaces
        words   := S . Fields     (text)            // Split into words

        gaps    := len (words) - 1                  // Nr of gaps

        per_gap := 0                                // Calculate amount
        if gaps > 0 {                               //   of spaces needed
            per_gap = spaces / gaps
        }
        end     := spaces - gaps * per_gap

        fmt . Println ("\"" + S . Join (words, S . Repeat (" ", per_gap)) +
                                               S . Repeat (" ", end)      +
                       "\"")
    }
}
