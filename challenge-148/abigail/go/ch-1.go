package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
)

func main () {
    for i := 0; i <= 100; i ++ {
        u := i % 10
        t := i / 10
        if !(i == 0 || t == 1 || u == 1 || t == 7 || u == 7 ||
                       t == 8 || u == 8 || t == 9 || u == 9 ||
                       t == 2 || u == 3 || u == 5 || i == 100) {
            fmt . Printf ("%d ", i)
        }
    }
    fmt . Printf ("\n")
}
