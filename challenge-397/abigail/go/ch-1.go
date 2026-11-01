package main

import (
    "fmt"
    "bufio"
    "os"
    "slices"
    "strings"
    "strconv"
)

func slice_of_int (line string) [] int {
    parts   := strings . Fields (line)
    numbers := make ([] int, len (parts))
    for i, part := range (parts) {
        numbers [i], _ = strconv . Atoi (part)
    }
    return (numbers)
}

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        line, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        numbers := slice_of_int (line)
        slices . Sort (numbers)
        sum := 0
        for _, number := range (numbers) {
            sum += number
        }
        avg := sum / len (numbers)
        res := 1 + avg
        if res <= 0 {
            res = 1
        }

        for _, number := range (numbers) {
            if number == res {
                res ++
            }
            if number >  res {
                break
            }
        }
        fmt . Printf ("%d\n", res)
    }
}
