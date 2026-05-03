package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "strconv"
)

//
// Return a power of 2. Don't care about overflows
//
func pow2 (exp int) int {
    out := 1
    for i := 1; i <= exp; i ++ {
        out *= 2
    }
    return (out)
}

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        //
        // Process a line of input:
        //    * Remove newline
        //    * Split on spaces
        //    * Turn strings into integers
        //
        parts := strings . Split (strings . TrimSuffix (text, "\n"), " ")
        var numbers [] int
        for _, p := range parts {
            number, _ := strconv . Atoi (p)
            numbers = append (numbers, number)
        }

        //
        // Try all masks except all 0's and all 1's
        //
        for mask := 1; mask < pow2 (len (numbers)) - 1; mask ++ {
            var set [] int
            sum := 0
            //
            // If the position of the value is in the mask, add the
            // difference of the value and it position to the sum.
            // and add the value to the current set
            //
            for index, val := range (numbers) {
                if mask & (1 << index) > 0 {
                    sum += val - index - 1
                    set = append (set, val)
                }
            }

            //
            // If the sum equals 0 (so the sum of the values equals the
            // sum of their positions), and we have at least two values
            // in the set, print it
            //
            if sum == 0 && len (set) > 1 {
                for i, val := range (set) {
                    fmt . Printf ("%d", val)
                    if i == len (set) - 1 {
                        fmt . Printf (";")
                    }
                    fmt . Printf (" ")
                }
            }
        }

        fmt . Printf ("\n")
    }
}
