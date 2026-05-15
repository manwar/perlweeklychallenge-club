package main

import (
    "fmt"
    "bufio"
    "os"
    S "strings"
    // "regexp"
    // "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        line, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        line   = S . ReplaceAll (line, "\n", "")  // Remove newline
        line   = S . ReplaceAll (line, " ",  "")  // Remove spaces
        line   = S . ReplaceAll (line, ".",  "")  // Remove dots
        parts := S . Split      (line, ";")       // Split on ;

        if parts [0] == parts [1] {               // Equal?
            fmt . Println ("true")
        } else {
            fmt . Println ("false")
        }
    }
}
