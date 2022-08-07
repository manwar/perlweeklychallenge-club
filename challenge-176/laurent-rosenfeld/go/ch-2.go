package main

import (
    "fmt"
    "strconv"
)

func reverse(n int) int {
    n_str := strconv.Itoa(n)
    rev := ""
    for _, v := range n_str {
        rev = string(v) + rev
    }
    rev_num, _ := strconv.Atoi(rev)
    return rev_num
}

func is_reversible(n int) bool {
    sum := n + reverse(n)
    sum_str := strconv.Itoa(sum)
    for i := 0; i < len(sum_str); i++ {
        if sum_str[i] % 2 == 0 {
            return false
        }
    }
    return true
}

func main() {
    for i := 1; i <= 100; i++ {
        if is_reversible(i) {
            fmt.Printf("%d ", i)
        }
    }
    fmt.Println("")
}
