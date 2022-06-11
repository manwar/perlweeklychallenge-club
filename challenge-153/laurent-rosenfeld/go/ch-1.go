package main

import "fmt"

func main() {
    left_fact := 1
    fact := 1
    for i := 1; i <= 10; i++ {
        fmt.Printf("%d ", left_fact)
        fact *= i
        left_fact += fact
    }
    fmt.Printf("\n")
}
