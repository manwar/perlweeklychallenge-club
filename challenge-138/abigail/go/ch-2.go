package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go < input-file
//

import (
    "fmt"
    "math"
)

func can_split (target int, number int) bool {
    if target >  number || target < 0 {return false}
    if target == number               {return true}

    pow_10 := 10

    for pow_10 <= number {
        if can_split (target - (number % pow_10), number / pow_10) {
            return true
        }
        pow_10 *= 10
    }

    return false
}

func main () {
    for {
        var number, sqrt int
        n, err := fmt . Scanf ("%d", &number)
        if (n != 1 || err != nil) {
            break
        }
        sqrt = int (math . Round (math . Sqrt (float64 (number))))
        if number > 1 && can_split (sqrt, number) {
            fmt . Println (1)
        } else {
            fmt . Println (0)
        }
    }
}
