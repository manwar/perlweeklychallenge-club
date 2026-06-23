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
        max := ' '
        sec := ' '
        chars := [] rune (text)
        for _, ch := range (chars) {
            if ch >= '0' && ch <= '9' {
                if max < ch             {sec = max; max = ch}
                if max > ch && ch > sec {sec = ch}
            }
        }
        if (sec != ' ') {
            fmt . Printf ("%c\n", sec)
        } else {
            fmt . Println ("-1")
        }
    }
}
