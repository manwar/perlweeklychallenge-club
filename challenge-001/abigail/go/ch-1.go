package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
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
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        fmt . Print   (strings . Replace (text, "e", "E", -1))
        fmt . Println (strings . Count (text, "e"))
    }
}
