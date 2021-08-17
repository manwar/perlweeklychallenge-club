package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
    "math"
)

func introot (square int) int {
    return (int (math . Round (math . Sqrt (float64 (square)))));
}

func main () {
    for {
        var n, n_sq, a, max_a, b, b_sq, c, c_sq int;
        var count, err = fmt . Scanf ("%d", &n);
        if (err != nil || count != 1) {
            break;
        }

        if (n <= 2) {
            fmt . Println ("-1");
            continue;
        }

        n_sq = n * n;
        c    = n + 1;
        c_sq = n_sq + 2 * n + 1;

        for 2 * c - 1 <= n_sq {
            b_sq = c_sq - n_sq;
            b    = introot (b_sq);

            if (b_sq == b * b) {
                fmt . Printf ("%d %d %d\n", n, b, c);
            }

            c_sq += 2 * c + 1;
            c    += 1;
        }

        max_a = int (float64 (n) / math . Sqrt (float64 (2)));

        a = 3;
        for a <= max_a {
            b_sq = n_sq - a * a
            b    = introot (b_sq)
            if (b_sq == b * b) {
                fmt . Printf ("%d %d %d\n", a, b, n);
            }
            a += 1;
        }
    }
}
