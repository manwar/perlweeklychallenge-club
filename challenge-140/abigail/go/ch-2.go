package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go < input-file
//

import (
    "fmt"
    "math"
)

func main () {
    for {
        var i, j, k int64
        c, err := fmt . Scanf ("%d %d %d", &i, &j, &k)
        if (c != 3 || err != nil) {
            break;
        }
        n := int64 (0)
        for ;k > 0; {
            n ++
            s := int64 (math . Sqrt (float64 (n)))
            for d := int64 (1); d <= s && k > 0; d ++ {
                if (n % d == 0) {
                    if (d <= i && n / d <= j) {k --}
                    if (d <= j && n / d <= i) {k --}
                    if (n == d * d)           {k ++}
                }
            }
        }
        fmt . Println (n)
    }
}
