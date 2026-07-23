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
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        todo := [] string {strings . TrimSpace (text)}
        for len (todo) > 0 {
            if strings . Index (todo [0], "?") >= 0 {
                todo = append (todo, strings . Replace (todo [0], "?", "0", 1),
                                     strings . Replace (todo [0], "?", "1", 1))
            } else {
                fmt . Printf ("%s ", todo [0])
            }
            todo = todo [1:]
        }
        fmt . Printf ("\n")
    }
}
