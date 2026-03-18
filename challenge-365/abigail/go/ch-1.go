package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-365
//

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "strconv"
)

func main () {
    reader := bufio . NewReader (os. Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        parts      := strings . Split (strings . TrimSpace (text), " ")
        word       := parts [0]
        count, err := strconv . Atoi (parts [1])
        if (err != nil) {
            break
        }

        //
        // Calculate the first digit sum
        //
        digit_sum := 0
        for _, rune := range word {
            char := int (rune) - int ('a') + 1
            digit_sum = digit_sum + (int (char / 10)) + (char % 10)
        }

        //
        // Repeatedly calculate subsequent digit sums
        //
        for i := 2; i <= count; i ++ {
            ds := 0
            for digit_sum > 0 {
                ds = ds + digit_sum % 10
                digit_sum = int (digit_sum / 10)
            }
            digit_sum = ds
        }
        fmt . Println (digit_sum)
    }
}
