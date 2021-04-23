package main

import "fmt"
func chowla(n int) int {
    var sum int = 0
    for i := 2; i <= n/2; i++ {
        if (n % i == 0) {
            sum += i;
        }
    }
    return sum;
}
func main() {
    const MAX int = 37
    for i := 1; i <= MAX; i++ {
        fmt.Print(chowla(i), " ")
    }
}
