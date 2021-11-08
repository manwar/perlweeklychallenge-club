package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go < input-file
//

import (
    "fmt"
)

func main () {
    for {
        var n, m int
        c, err := fmt . Scanf ("%d %d", &n, &m);
        if (c != 2 || err != nil) {
            break;
        }
        count := 0
        seen  := map [int] bool { }
        for i := 1; i <= n; i ++ {
            for j := 1; j <= m; j ++ {
                if _, ok := seen [i * j]; !ok {
                    count ++;
                    seen [i * j] = true;
                }
            }
        }
        fmt . Printf ("%d\n", count);
    }
}
