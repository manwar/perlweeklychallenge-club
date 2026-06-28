package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "strconv"
)

func pow (a int, exp int) int {
    res := 1
    for exp > 0 {
        if exp % 2 == 1 {
            res *= a
            exp -= 1
        } else {
            a *= a
            exp /= 2
        }
    }
    return res
}

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        line, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        parts    := strings . Fields (line)
        base,  _ := strconv . Atoi (parts [0])
        limit, _ := strconv . Atoi (parts [1])

        for n := 0; n <= limit; n ++ {
            size := 0;
            for n_c := n; n_c > 0; n_c /= base {
                size ++
            }
            sum := 0;
            for n_c := n; n_c > 0; n_c /= base {
                sum += pow (n_c % base, size)
            }
            if sum == n {
                fmt . Printf ("%d ", sum)
            }
        }
        fmt . Printf ("\n")
    }
}
