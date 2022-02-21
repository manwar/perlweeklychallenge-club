package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
//

//
// Run as: go run ch-2.go < input-file
//

import (
    "fmt"
)

func main () {
    var fac [10] int
    fac [0] = 1
    for n := 1; n <= 9; n ++ {
        fac [n] = n * fac [n - 1]
    }
    for {
        var num int
        c, err := fmt . Scanf ("%d", &num)
        if (c != 1 || err != nil) {
            break
        }
        n := num
        sum := 0
        for n > 0 {
            sum += fac [n % 10]
            n   /= 10
        }
        if num == sum {
            fmt . Printf ("1\n")
        } else {
            fmt . Printf ("0\n")
        }
    }
}
