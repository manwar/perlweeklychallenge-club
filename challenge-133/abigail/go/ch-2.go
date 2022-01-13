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

func digitsum (numbers [] int) int {
    base := 10
    sum  := 0
    for _, number := range numbers {
        for number > 0 {
            sum    += number % base
            number /= base
        }
    }
    return sum
}


func factors (number int) [] int {
    var f [] int
    small_primes := [] int {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31}
    d := 0
    for d < len (small_primes) && number > 1 {
        prime := small_primes [d]
        for number % prime == 0 {
            f = append (f, prime)
            number /= prime
        }
        d ++
    }
    if (number > 1) {
        f = append (f, number)
    }

    return (f)
}

func main () {
    count := 10
    n     := 0
    for count > 0 {
        n = n + 1
        f := factors (n)
        if len (f) > 1 && digitsum ([] int {n}) == digitsum (f) {
            fmt . Println (n)
            count = count - 1
        }
    }
}
