package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-003
//

//
// Run as: go run ch-1.go < input-file
//

import (
    "fmt"
)

func main () {
    var max int
    for {
        n, err := fmt . Scanf ("%d", &max)
        if (n != 1 || err != nil) {
            break
        }
        ugly := make ([] int, max)
        ugly [0] = 1
        count   := 0
        next_2  := 0
        next_3  := 0
        next_5  := 0
        min     := 0

        for count < max - 1 {
            count ++

            c2 := 2 * ugly [next_2]
            c3 := 3 * ugly [next_3]
            c5 := 5 * ugly [next_5]
            if c2 <= c3 && c2 <= c5 {min = c2}
            if c3 <= c2 && c3 <= c5 {min = c3}
            if c5 <= c2 && c5 <= c3 {min = c5}
            ugly [count] = min

            if (c2 <= ugly [count]) {next_2 ++}
            if (c3 <= ugly [count]) {next_3 ++}
            if (c5 <= ugly [count]) {next_5 ++}
        }
        fmt . Println (ugly [count])
    }
}
