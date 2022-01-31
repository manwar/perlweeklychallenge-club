package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
//

//
// Run as: go run ch-1.go < input-file
//

import (
    "fmt"
)

func digit_sum (n int) int {
    sum  := 0
    base := 10
    for n > 0 {
        sum += n % base
        n   /= base
    }
    return (sum)
}

var fib_prev, fib_last int
var fib map [int] bool

func fib_init () {
    fib            = make (map [int] bool)
    fib_prev       = 0
    fib_last       = 1
    fib [fib_prev] = true
    fib [fib_last] = true
}


func is_fib (n int) bool {
    for fib_last < n {
        t             := fib_last
        fib_last      += fib_prev
        fib_prev       = t
        fib [fib_last] = true
    }

    _, ok := fib [n]

    return (ok)
}


func main () {
    fib_init ()
    for {
        var n int

        c, err := fmt . Scanf ("%d", &n)
        if c != 1 || err != nil {
            break
        }

        for k := 0; n > 0; k ++ {
            if is_fib (digit_sum (k)) {
                fmt . Printf ("%d ", k)
                n -= 1
            }
        }
        fmt . Printf ("\n")
    }
}
