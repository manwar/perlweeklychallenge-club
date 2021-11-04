package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
    "math"
)

func main () {
    for {
        var num int
        n, err := fmt . Scanf ("%d", &num)
        if n != 1 || err != nil {
            break
        }
        fmt . Printf ("%.0f\n", math . Exp (math . Log (float64 (num)) / 2))
    }
}
