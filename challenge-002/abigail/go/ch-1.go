package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
//

//
// Run as: go run ch-1.go < input-file
//

import (
    "fmt"
)

func main () {
    var i int;
    for {
        var n, err = fmt . Scanf ("%d", &i)
        if n != 1 || err != nil {
            break
        }
        fmt . Println (i)
    }
}
