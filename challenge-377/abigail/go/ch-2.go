package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "unicode/utf8"
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
        words := strings . Fields (text)
        count := 0
        for i := 0; i < len (words) - 1; i ++ {
            for j := i + 1; j < len (words); j ++ {
                w1 := words [i]
                w2 := words [j]
                l1 := utf8 . RuneCountInString (w1)
                l2 := utf8 . RuneCountInString (w2)
                if l2 > l1 {
                    w1, w2 = w2, w1
                    l1, l2 = l2, l1
                }
                if strings .     Index (w1, w2) == 0 &&
                   strings . LastIndex (w1, w2) == l1 - l2 {
                    count ++
                }
            }
        }
        fmt . Println (count)
    }
}
