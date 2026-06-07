package main

import (
    "fmt"
    "bufio"
    "os"
    // "strings"
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
        f1 := text [0]
        r1 := text [1]
        sp := text [2]
        f2 := text [3]
        r2 := text [4]
        if f1 < 'a' || f1 > 'h' || r1 < '1' || r1 > '8' ||
           f2 < 'a' || f2 > 'h' || r2 < '1' || r2 > '8' || sp != ' ' {
            fmt . Fprintln (os . Stderr, "Cannot parse input\n")
            os . Exit (1)
        }

        p1 := (text [0] % 2) == (text [1] % 2)
        p2 := (text [3] % 2) == (text [4] % 2)
        if p1 == p2 {
            fmt . Println ("true")
        } else {
            fmt . Println ("false")
        }
    }
}
