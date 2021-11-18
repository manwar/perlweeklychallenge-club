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
    "strconv"
)

func main () {
    var reader = bufio . NewReader (os. Stdin)
    for {
        var line, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        line = strings . TrimSuffix (line, "\n")

        list   := strings . Split (line, " ")

        sorted := true
        for i := 1; sorted && i < len (list); i ++ {
            prev, _ := strconv . Atoi (list [i - 1])
            next, _ := strconv . Atoi (list [i])
            sorted = prev <= next
        }

        if (sorted) {
            fmt . Println (1)
        } else {
            fmt . Println (0)
        }
    }
}
