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
        parts := strings . Fields (text)

        nr_of_notes := len (parts) / 2
        notes := make ([] string, nr_of_notes)
        for i := 1; i <= nr_of_notes; i ++ {
            pos, _ := strconv . Atoi (parts [i + nr_of_notes])
            notes [pos - 1] = parts [i]
        }
        fmt . Printf ("%s => %s\n", strings . ToUpper (parts [0]),
                                    strings . Join (notes, " "))
    }
}
