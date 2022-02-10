package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
//

//
// Run as: go run ch-2.go < input-file
//

import (
    "fmt"
    "bufio"
    "os"
    "strconv"
    "strings"
)

func max (a int, b int) int {
    if a < b {
        return b
    }
    return a
}

func main () {
    var reader = bufio . NewReader (os. Stdin)
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        s := strings . Fields (strings . Trim (text, "\n"))
        h := make ([] int, len (s))
        for i, v := range s {
            n, _ := strconv . Atoi (v)
            h [i] = n
        }
        h = append (h, 0, 0)

        for i := len (h) - 3; i >= 2; i -- {
            h [i] = max (h [i] + h [i + 2], h [i + 1])
        }

        fmt . Println (h [0] + h [2])
    }
}
