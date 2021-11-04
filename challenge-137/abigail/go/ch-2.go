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

func reverse (num int) int {
    rev := 0
    for num > 0 {
        rev *= 10
        rev += num % 10
        num /= 10
    }
    return rev
}

func ly (n int) int {
    if n >= 10000000    {return 1}
    if n == reverse (n) {return 0}
    return ly (n + reverse (n))
}

func main () {
    for {
        var num int
        n, err := fmt . Scanf ("%d", &num)
        if n != 1 || err != nil {
            break
        }
        fmt . Println (ly (num))
    }
}
