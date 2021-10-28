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

var cache map [int] map [int] int

func _count (target int, this_fib int, prev_fib int) int {
    if _, ok := cache [target]; !ok {
        cache [target] = make (map [int] int)
    }

    if _, ok := cache [target] [this_fib]; !ok {
        var result int
               if target <  this_fib {
            result = 0
        } else if target == this_fib {
            result = 1
        } else {
            result = _count (target - this_fib, this_fib + prev_fib, this_fib) +
                     _count (target,            this_fib + prev_fib, this_fib)
        }
        cache [target] [this_fib] = result
    }

    return cache [target] [this_fib]
}

func count (target int) int {
    return _count (target, 1, 1)
}

func main () {
    cache = make (map [int] map [int] int)
    for {
        var n int
        c, err := fmt . Scanf ("%d", &n)
        if c != 1 || err != nil {
            break;
        }

        fmt . Printf ("%d\n", count (n))
    }
}
