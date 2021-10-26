package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
//  "bufio"
//  "os"
)

//
// Find the GCD, using Stein's algorithm
//    (https://en.wikipedia.org/wiki/Binary_GCD_algorithm)
//
func gcd (u int, v int) int {
    var u_odd bool = u % 2 != 0
    var v_odd bool = v % 2 != 0

    if (u == v || v == 0) {return u}
    if (          u == 0) {return v}
    if (!u_odd && !v_odd) {return gcd (u >> 1, v >> 1) << 1}
    if (!u_odd &&  v_odd) {return gcd (u >> 1, v)}
    if ( u_odd && !v_odd) {return gcd (u,      v >> 1)}
    if ( u     >   v)     {return gcd (u - v,  v)}
                           return gcd (v - u,  u)
}

func main () {
    var power_of_2 map [int] int = make (map [int] int)
    for i := 1; i < 62; i ++ {
        power_of_2 [i << 1] = 1
    }

    for {
        var n, m int
        c, err := fmt . Scanf ("%d %d", &n, &m);
        if c != 2 || err != nil {
            break;
        }
        if _, ok := power_of_2 [gcd (m, n)]; ok {
            fmt . Print ("1\n")
        } else {
            fmt . Print ("0\n")
        }
    }
}
