package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go < input-file
//

import (
    "fmt"
    "strconv"
)

func substrings (n string, m int, prefix int, max int) int {
    var n_prefix int;
    if len (n) == 0 {
        if prefix > -1  &&
           prefix < max &&
           prefix % m == 0 {
            return 1
        } else {
            return 0
        }
    }

    fc, _ := strconv . Atoi (n [0:1])
    if prefix == -1 {
        n_prefix = fc
    } else {
        n_prefix = 10 * prefix + fc
    }
    tail := n [1:]
    
    return substrings (tail, m, n_prefix, max) +
           substrings (tail, m,   prefix, max)
}

func main () {
    for {
        var n, m  int
        c, err := fmt . Scanf ("%d %d", &n, &m)
        if c != 2 || err != nil {
            break
        }
        fmt . Println (substrings (strconv . Itoa (n), m, -1, n))
    }
}
