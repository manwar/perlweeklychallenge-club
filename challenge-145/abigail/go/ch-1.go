package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go < input-file
//

import (
    "fmt"
    "bufio"
    "os"
    "strconv"
    "strings"
)

func main () {
    reader := bufio   . NewReader (os. Stdin)
    a, _   := reader  . ReadString ('\n')
    b, _   := reader  . ReadString ('\n')
    aa     := strings . Split (strings . Trim (a, "\n"), " ")
    bb     := strings . Split (strings . Trim (b, "\n"), " ")
    sum    := 0

    for i := 0; i < len (aa); i ++ {
        a, _ := strconv . Atoi (aa [i])
        b, _ := strconv . Atoi (bb [i])
        sum += a * b
    }

    fmt . Println (sum)
}
