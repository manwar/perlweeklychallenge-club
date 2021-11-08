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

func steps (x int, y int, path string) {
    if (x == 0 && y == 0) {
        fmt . Println (path)
    }
    if (x > 0) {
        steps (x - 1, y + 1, path + "L")
        steps (x - 1, y,     path + "R")
    }
    if (y > 0) {
        steps (x,     y - 1, path + "H")
    }
}

func main () {
    var x int
    var n, err = fmt . Scanf ("%d", &x)
    if (n == 1 && err == nil) {
        steps (x, 0, "")
    }
}
