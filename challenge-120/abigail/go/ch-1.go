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
    for {
        var n, num int
        n, _ = fmt . Scanf ("%d", &num)
        if (n != 1) {
            break
        }
        fmt . Printf ("%d\n", (num & 0x55) << 1 |
                              (num & 0xAA) >> 1)
    }
}
