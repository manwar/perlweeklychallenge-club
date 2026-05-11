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
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        text   = S . ReplaceAll (text, "\n", "")  // Remove newline
        text   = S . ReplaceAll (text, " ",  "")  // Remove spaces
        text   = S . ReplaceAll (text, ".",  "")  // Remove dots
        parts := S . Split      (text, ";")       // Split on ;

        if parts [0] == parts [1] {               // Equal?
            fmt . Println ("true")
        } else {
            fmt . Println ("false")
        }
    }
}
