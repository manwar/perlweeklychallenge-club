package main

import (
    "fmt"
    "strconv"
)

func is_esthetic(n int) bool {
    s := strconv.Itoa(n)
    for i := 1; i < len(s); i++ {
        if s[i]-s[i-1] != 1 && s[i-1]-s[i] != 1 {
            return false
        }
    }
    return true
}
func main() {
    tests := []int{5456, 120, 121, 23456, 2346, 7654567, 765467}
    for _, test := range tests {
        if is_esthetic(test) {
            fmt.Printf("%-9d is esthetic\n", test)
        } else {
            fmt.Printf("%-9d is not esthetic\n", test)
        }
    }
}
