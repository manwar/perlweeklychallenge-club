package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        line, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        line = strings . TrimSuffix (line, "\n")
        chars := [] rune (line)
        for i, j := 0, len (chars) - 1; i < j; i, j = i + 1, j - 1 {
            t := chars [i]
            chars [i] = chars [j]
            chars [j] = t
        }
        line = string (chars)
        fmt . Printf ("%s\n", line)
    }
}
