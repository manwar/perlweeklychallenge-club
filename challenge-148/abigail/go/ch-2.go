package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
//

//
// Run as: go run ch-2.go
//

import (
    "fmt"
    "math"
)

func main () {
    const COUNT int = 5
    const A     int = 0
    const B     int = 1
    const C     int = 2
    const SUM   int = 3

    out   := [COUNT] [4] int {}
    for i := 0; i < COUNT; i ++ {
        out [i] [A]   = 999999
        out [i] [B]   = 999999
        out [i] [C]   = 999999
        out [i] [SUM] = out [i] [A] + out [i] [B] + out [i] [C]
    }

    max_index := 0

    for k := 0; 3 * k + 2 <= out [max_index] [SUM]; k ++ {
        a  := 3 * k + 2
        f1 :=     k + 1
        f2 := 8 * k + 5

        var d1 [] int
        var d2 [] int

        //
        // Get the divisors of f1
        //
        for i := 1; i * i <= f1; i ++ {
            if f1 % i == 0 {
                d1 = append (d1, i)
                if (i != f1 / i) {
                    d1 = append (d1, f1 / i)
                }
            }
        }

        //
        // Get the divisors of f2 (or rather, their square roots,
        // if the square roots are integers)
        //

        for i := 1; i * i <= f2; i ++ {
            if (f2 % i == 0) {
                s1 := int (math . Sqrt (float64 (i)))
                s2 := int (math . Sqrt (float64 (f2 / i)))
                if s1 * s1 == i {
                    d2 = append (d2, s1)
                }
                if s2 * s2 == f2 / i && s2 != s1 {
                    d2 = append (d2, s2)
                }
            }
        }

        for _, d1v := range (d1) {
            for _, d2v := range (d2) {
                b := d1v * d2v
                c := f1 * f1 * f2 / (b * b)

                if a + b + c < out [max_index] [SUM] {
                    //
                    // Avoid duplicates
                    //
                    seen := false
                    for i := 0; i < COUNT; i ++ {
                        if out [i] [A] == a && out [i] [B] == b {
                            seen = true
                            break
                        }
                    }

                    if seen {
                        break
                    }

                    //
                    // Update with better value
                    //
                    out [max_index] [A]   = a
                    out [max_index] [B]   = b
                    out [max_index] [C]   = c
                    out [max_index] [SUM] = a + b + c

                    //
                    // Find the next max index
                    //
                    max_index = 0
                    max_sum  := out [max_index] [SUM]
                    for l := 1; l < COUNT; l ++ {
                        if out [l] [SUM] > max_sum {
                            max_sum   = out [l] [SUM]
                            max_index = l
                        }
                    }
                }
            }
        }
    }

    //
    // Print the results
    //
    for i := 0; i < COUNT; i ++ {
        fmt . Printf ("%d %d %d\n", out [i] [A], out [i] [B], out [i] [C])
    }
}
