package main

import (
    "fmt"
    "bufio"
    "os"
    // "strings"
    "regexp"
    "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        numbers := regexp . MustCompile (`-?[0-9]+`) . FindAllString (text, -1)
        r1, _ := strconv . Atoi (numbers [0])
        i1, _ := strconv . Atoi (numbers [1])
        r2, _ := strconv . Atoi (numbers [2])
        i2, _ := strconv . Atoi (numbers [3])
        r := r1 * r2 - i1 * i2
        i := r1 * i2 + r2 * i1

        ft := "%d+%di\n"
        if i < 0 {
            ft = "%d+(%d)i\n"
        }
        fmt . Printf (ft, r, i)
    }
}
