package main

import (
    "fmt"
    "bufio"
    "os"
    S "strings"
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
        //
        // Remove trailing newline, and split on whitespace
        //
        text    = S . TrimSuffix (text, "\n")
        list   := S . Fields (text);

        //
        // First element is n; turn string into number, and shift list
        //
        n, err := strconv . Atoi (list [0])
        list    = list [1:]

        //
        // Special case if n exceeds the size of the list
        //
        if n > len (list) {
            fmt . Println ("-1;")
            continue
        }

        //
        // Calculate the number of elements per set, and
        // the number of sets which gets one more
        //
        per_set  := len (list) / n
        overflow := len (list) - n * per_set

        for i := 1; i <= n; i ++ {
            set_size := per_set     // Calculate size of current set
            if i <= overflow {
                set_size ++
            }
            fmt . Printf ("%s", S . Join (list [:set_size], " ") + "; ")
            list = list [set_size:]
        }
        fmt . Println ("")
    }
}
