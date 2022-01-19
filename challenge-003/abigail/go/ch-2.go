package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-003
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

        current_row := make ([] int, 1)
        current_row [0] = 1;
        fmt . Printf ("1\n")

        for row := 1; row <= max; row ++ {
            next_row := make ([] int, row + 1)
            next_row [0]   = 1
            next_row [row] = 1
            fmt . Printf ("1 ")
            for col := 1; col < row; col ++ {
                next_row [col] = current_row [col - 1] + current_row [col]
                fmt . Printf ("%d ", next_row [col])
            }
            fmt . Printf ("1\n")
            current_row = next_row
        }
    }
}
