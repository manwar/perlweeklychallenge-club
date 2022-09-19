package main

import (
    "fmt"
    "math"
    "strconv"
)

func is_disarium(num int) bool {
    n := num
    i := 0
    sum := 0
    l := len(strconv.Itoa(n))
    for n > 0 {
        sum += int(math.Pow(float64(n%10), float64(l-i)))
        n /= 10
        i++
    }
    return sum == num
}
func main() {
    i := 0
    count := 0
    for count < 19 {
        if is_disarium(i) {
            fmt.Printf("%d ", i)
            count++
        }
        i++
    }
    fmt.Println("")
}
