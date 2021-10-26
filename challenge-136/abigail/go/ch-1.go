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

func is_power_of_n (number int, n int) bool {
    if (number <  1)     {return false}
    if (number == 1)     {return true}
    if (number % n != 0) {return false}
                          return is_power_of_n (number / n, n)
}
func is_power_of_2 (number int) bool {
    return is_power_of_n (number, 2)
}

func main () {
    for {
        var n, m int
        c, err := fmt . Scanf ("%d %d", &n, &m);
        if c != 2 || err != nil {
            break;
        }
        if r := gcd (m, n); r > 1 && is_power_of_2 (r) {
            fmt . Print ("1\n")
        } else {
            fmt . Print ("0\n")
        }
    }
}
