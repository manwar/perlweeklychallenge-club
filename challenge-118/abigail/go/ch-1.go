package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
    "strconv"
)

func reverse (str string) string {
    rev := [] rune (str)
    for i, j := 0, len (rev) - 1; i < j; i, j = i + 1, j - 1 {
        rev [i], rev [j] = rev [j], rev [i]
    }
    return string (rev)
}

func main () {
    var dec int64
    for {
        var n, err = fmt . Scanf ("%d", &dec)
        if (n != 1 || err != nil) {
            break
        }
        var bin = strconv . FormatInt (dec, 2)
        if (bin == reverse (bin)) {
            fmt . Println (1)
        } else {
            fmt . Println (0)
        }
    }
}



