package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    // "regexp"
    "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        text     = strings . TrimSuffix (text, "\n")

        //
        // Parse input. Need to make the size an integer
        //
        parts   := strings . Split (text, " ")
        str     :=                  parts [0]
        size, _ := strconv . Atoi  (parts [1])
        filler  :=                  parts [2]

        //
        // Add 'size - 1' times the filler character to the string
        //
        str     = str + strings . Repeat (filler, size - 1)

        //
        // Repeatedly extract 'size' characters (or rather bytes, but
        // we work with ASCII strings) from 'str' and add them to the
        // 'out' slice. At the end of the loop, 'str' may be non-empty,
        // but it will contain nothing but filler characters.
        //
        var out [] string
        for len (str) >= size {
            out = append (out, str [:size])
            str = str [size:]
        }

        //
        // Print results, comma separated
        //
        fmt . Println (strings . Join (out, " "))
    }
}
