package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go
//

import (
    "fmt"
    "bufio"
    "os"
)

func main () {
    var reader = bufio . NewReader (os. Stdin)
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        var a, b int;
        var n, err2 = fmt . Sscanf (text, "%d/%d", &a, &b)
        if (n != 2 || err2 != nil) {
            continue
        }
        for i := 1; i <= 2; i ++ {
            if a < b {
                b -= a
            } else {
                a -= b
            }
            if a == 0 || b == 0 {
                break
            }
            fmt . Printf ("%d/%d ", a, b)
        }
        fmt . Println ("")
    }
}
