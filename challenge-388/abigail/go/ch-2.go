package main

import (
    "fmt"
    "bufio"
    "os"
    "strconv"
    "strings"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        n, _ := strconv . Atoi (strings . TrimSpace (text))
        sf := 1
        for i := 1; i <= n; i ++ {
            sf = i * sf + 1 - 2 * (i % 2)
        }
        fmt . Printf ("%d\n", sf)
    }
}
