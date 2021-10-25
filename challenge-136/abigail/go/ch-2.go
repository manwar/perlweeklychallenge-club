package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go
//

import (
    "fmt"
)

func count (target int, this_fib int, prev_fib int) int {
    if target <  this_fib {return 0}
    if target == this_fib {return 1}
    return count (target - this_fib, this_fib + prev_fib, this_fib) +
           count (target,            this_fib + prev_fib, this_fib)
}

func main () {
    for {
        var n int
        c, err := fmt . Scanf ("%d", &n)
        if c != 1 || err != nil {
            break;
        }

        fmt . Printf ("%d\n", count (n, 1, 1))
    }
}
