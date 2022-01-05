package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
//

//
// Run as: go run ch-2.go < input-file
//

import (
    "fmt"
    "flag"
    "bufio"
    "os"
    "strconv"
    "strings"
)

func main () {
    to_base   := flag . Bool ("t", false, "a bool")
    from_base := flag . Bool ("f", false, "a bool")

    flag . Parse ()

    var reader = bufio . NewReader (os. Stdin)
    for {
        var line, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        line = strings . Trim (line, "\n")
        if *from_base {
            i, err := strconv . ParseInt (line, 35, 0)
            if (err == nil) {
                fmt . Println (i)
            }
        }
        if *to_base {
            i, err := strconv . ParseInt (line, 10, 0)
            if (err == nil) {
                fmt . Println (strings . ToUpper (strconv . FormatInt (i, 35)))
            }
        }
    }
}
