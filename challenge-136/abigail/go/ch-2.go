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

func _count (target int, this_fib int, prev_fib int) int {
    if target <  this_fib {return 0}
    if target == this_fib {return 1}
    return _count (target - this_fib, this_fib + prev_fib, this_fib) +
           _count (target,            this_fib + prev_fib, this_fib)
}

func count (target int) int {
    return _count (target, 1, 1)
}

func main () {
    for {
        var n int
        c, err := fmt . Scanf ("%d", &n)
        if c != 1 || err != nil {
            break;
        }

        fmt . Printf ("%d\n", count (n))
    }
}
