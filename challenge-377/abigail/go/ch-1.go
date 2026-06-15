package main

import (
    "fmt"
    "bufio"
    "os"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
  outer:
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        chars := [] rune (text)
        for i, c := range chars {
            for j, d := range (chars) {
                if c == d && i < len (chars) - 1 &&
                             j > 0 && chars [i + 1] == chars [j - 1] {
                    fmt . Println ("true")
                    continue outer
                }
            }
        }
        fmt . Println ("false")
    }
}
