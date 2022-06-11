package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
//

//
// Run as: go run ch-2.go
//

import (
    "fmt"
)

func main () {
    p := 0
    n := 0
    pentagon := map [int] bool { }
    for {
        p = p + n + n + n + 1
        n ++
        pentagon [p] = true
        for seen := range pentagon {
            if seen + seen < p && pentagon [p - seen] &&
                                  pentagon [p - seen - seen] {
                fmt . Printf ("%d %d\n", seen, p - seen)
                return
            }
        }
    }
}
