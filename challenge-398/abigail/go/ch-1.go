package main

import (
    "fmt"
    "bufio"
    "os"
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
        sum     := 0
        count   := 0
        for _, number := range (numbers) {
            if number % 6 == 0 {
                sum += number
                count ++
            }
        }
        res := 0
        if sum != 0 {
            res = int (.5 + (float64 (sum) / float64 (count)))
        }
        fmt . Println (res)
    }
}
