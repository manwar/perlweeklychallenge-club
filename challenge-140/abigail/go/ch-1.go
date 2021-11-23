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
    "strconv"
    "strings"
)

func main () {
    var reader = bufio . NewReader (os. Stdin)
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        bins := strings . Split (strings . Trim (text, "\n"), " ")
        a, _ := strconv . ParseInt (bins [0], 2, 0) 
        b, _ := strconv . ParseInt (bins [1], 2, 0) 
        
        fmt . Println (strconv . FormatInt (a + b, 2))
    }
}
