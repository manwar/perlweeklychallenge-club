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
    count          := 10
    nr_of_divisors :=  8

    for n := 1; count > 0; n ++ {
        s := int (math . Sqrt (float64 (n)))
        if n == s * s {
            continue
        }
        c := 0
        for m := 1; m <= s && c <= nr_of_divisors; m ++ {
            if n % m == 0 {
                c += 2
            }
        }
        if c == nr_of_divisors {
            fmt . Println (n)
            count --
        }
    }
}
