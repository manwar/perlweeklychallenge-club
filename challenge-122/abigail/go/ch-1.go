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
    var n, s, c int;
    s = 0
    c = 0
    for {
        var _, err = fmt . Scanf ("%d", &n)
        if (err != nil) {
            break
        }
        s += n
        c ++
        fmt . Printf ("%d\n", s / c)
    }
}
