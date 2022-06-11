package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
//

//
// Run as: go run ch-2.go
//

import (
    "fmt"
)

func main () {
    primes := [8] int {2, 3, 5, 7, 11, 13, 17, 19}
    for n := 1; n <= 500; n ++ {
        s := false
        for _, p := range primes {
            if (n % (p * p) == 0) {
                s = true
                break
            }
        }
        if !s {
            fmt . Printf ("%d ", n)
        }
    }
    fmt . Printf ("\n")
}
