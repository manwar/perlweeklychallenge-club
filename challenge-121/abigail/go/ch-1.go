package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
)

func main () {
    var m, n, c int

    for {
        c, _ = fmt . Scanf ("%d %d", &m, &n)
        if (c != 2) {
           break
        }
        fmt . Printf ("%d\n", m ^ (1 << (n - 1)))
    }
}
