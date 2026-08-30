package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "strconv"
)

func process (n int, u int, d int, prefix string) {
    if d == n {fmt . Printf ("%s ", prefix)}
    if d < u  {process (n, u, d + 1, prefix + "D")}
    if u < n  {process (n, u + 1, d, prefix + "U")}
}

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        n, _ := strconv . Atoi (strings . TrimSpace (text))
        process (n, 0, 0, "")
        fmt . Printf ("\n")
    }
}
