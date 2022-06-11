package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
)

func is_prime (num int) bool {
    if num == 2 {
        return true
    }
    if num % 2 == 0 {
        return false
    }
    for i := 3; i * i <= num; i += 2 {
        if num % i == 0 {
            return false
        }
    }
    return true
}

func main () {
    todo := [] int {2, 3, 5, 7}
    for _, n := range todo {
        fmt . Printf ("%d ", n)
    }
    count := 20 - len (todo)
    pow   := 10
    for count > 0 && len (todo) > 0 {
        new_todo := [] int {}
        for d := 1; (d <= 9) && (count > 0); d ++ {
            for _, p := range (todo) {
                candidate := d * pow + p
                if is_prime (candidate) {
                    fmt . Printf ("%d ", candidate)
                    new_todo = append (new_todo, candidate)
                    count --
                }
                if count <= 0 {
                    break
                }
            }
        }
        todo = new_todo
        pow *= 10
    }
    fmt . Print ("\n")
}
