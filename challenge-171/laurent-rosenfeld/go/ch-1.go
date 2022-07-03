package main

import "fmt"

func main() {
    var count = 0
    var j = 1
    for count < 20 {
        if is_abundant(j) {
            fmt.Printf("%d ", j)
            count++
        }
        j += 2
    }
}

func is_abundant(n int) bool {
    var sum = 0
    for i := 1; i < n/2; i++ {
        if n%i == 0 {
            sum += i
            if sum > n {
                return true
            }
        }
    }
    return false
}
