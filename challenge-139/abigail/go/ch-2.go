package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go
//

import (
    "fmt"
)

var (
    BASE  int = 10
    COUNT int =  5
)

func is_long (number int) bool {
    seen := make ([] bool, number)
    rest := 0
    for i := 2; i <= number; i ++ {
        rest = (rest * BASE + BASE - 1) % number
        if seen [rest] {
            return false
        }
        seen [rest] = true
    }
    return true
}


func main () {
    number := 1
    for COUNT > 0 {
        number ++
        if BASE % number == 0 {
            continue
        }
        if is_long (number) {
            fmt . Println (number)
            COUNT --
        }
    }
}
