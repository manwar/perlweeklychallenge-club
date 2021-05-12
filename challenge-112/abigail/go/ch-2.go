package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go
//

import "fmt"
import "math"

var SQRT5 float64 = math . Sqrt (5)
var PHI   float64 = (1 + SQRT5) / 2

func main () {
    for {
        var n, r float64
        c, _ := fmt . Scanf ("%f", &n)
        if (c != 1) {
            break
        }
        r = math . Round (math . Pow (PHI, (n + 1)) / SQRT5)
        fmt . Printf ("%d\n", (int) (r))
    }
}
