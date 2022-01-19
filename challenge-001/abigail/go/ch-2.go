package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
//

//
// Run as: go run ch-2.go < input-file
//

import (
    "fmt"
)

func main () {
    for {
        var max int
        n, err := fmt . Scanf ("%d", &max)
        if n != 1 || err != nil {
            break
        }
        for i := 1; i <= max; i ++ {
            if i % 15 == 0 {
                fmt . Println ("fizzbuzz")
                continue
            }
            if i %  5 == 0 {
                fmt . Println (    "buzz")
                continue
            }
            if i %  3 == 0 {
                fmt . Println ("fizz"    )
                continue
            }
            fmt . Println (i)
        }
    }
}
