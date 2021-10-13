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

func main () {
    for _, t := range [] int {789, 798, 879, 897, 978} {
        fmt . Printf ("1023456%d\n", t)
    }
}
