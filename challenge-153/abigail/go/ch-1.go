package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
)

func main () {
    sum := 1
    fac := 1
    fmt . Printf ("%d", sum)
    for n := 1; n <= 9; n ++ {
        fac *= n
        sum += fac
        fmt . Printf (" %d", sum)
    }
    fmt . Printf ("\n")
}
