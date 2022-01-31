package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
//

//
// Run as: go run ch-1.go < input-file
//

import (
    "fmt"
    "bufio"
    "os"
    "strings"
)

func main () {
    var reader = bufio . NewReader (os. Stdin)
    LENGTH    := 51
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        fibs     := strings . Split (strings . Trim (text, "\n"), " ")
        fib_prev := fibs [0]
        fib_last := fibs [1]

        for len (fib_last) < LENGTH {
            fib_prev, fib_last = fib_last, fib_prev + fib_last
        }
        fmt . Printf ("%c\n", fib_last [LENGTH - 1])
    }
}
