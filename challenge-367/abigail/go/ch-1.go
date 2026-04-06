package main

import (
    "fmt"
    "bufio"
    "os"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        //
        // Iterate over the input string, count (runes) '0' and '1'.
        // We'll iterate over the trailing newline, but won't do anything
        //
        count_0 := 0
        count_1 := 0
        for _, ch := range (text) {
            switch ch {
                case '0': count_0 ++
                case '1': count_1 ++
            }
        }
        //
        // Print the appropriate number of 1's, 0's, and the trailing 1
        //
        for i := 1; i < count_1; i ++ {
            fmt . Printf ("1")
        }
        for i := 0; i < count_0; i ++ {
            fmt . Printf ("0")
        }
        fmt . Println ("1")
    }
}
