package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        numbers := strings . Fields (text [:len (text) - 1])
        min_c, max_c, min, max := 0, 0, 0, 0
        for _, value := range (numbers) {
            number, _ := strconv . Atoi (value)
            if min_c == 0 || number < min {min_c, min = 0, number}
            if max_c == 0 || number > max {max_c, max = 0, number}
            if number == min {min_c ++}
            if number == max {max_c ++}
        }
        if min == max {
            max_c = 0
        }
        fmt . Printf ("%d\n", len (numbers) - min_c - max_c)
    }
}
