package main

import (
    "fmt"
    "bufio"
    "os"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        sum := 0
        for i, ch := range ([] rune (text)) {
            if 'a' <= ch && ch <= 'z' {
                sum += (i + 1) * ('z' - int (ch) + 1)
            }
        }
        fmt . Printf ("%d\n", sum)
    }
}
