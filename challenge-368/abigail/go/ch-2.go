package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    // "regexp"
    "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if err != nil {
            break
        }

        //
        // Parse input. Break the input line into two parts, and
        // turn those parts into integers
        //
        parts        := strings . Split (strings . TrimSuffix (text, "\n"), " ")
        number, err1 := strconv . Atoi  (parts [0])
        mode,   err2 := strconv . Atoi  (parts [1])
        if err1 != nil || err2 != nil {
            break
        }

        diff_factors := 0
             factors := 0

        //
        // Try dividing by all odd numbers -- but use 2 if the number is 1.
        // Count different and total factors.
        //
        // Note that this way, we will never divide by a composite number --
        // if we encounter a composite number, we have already tried its
        // factors.
        //
        for d := 1; d * d <= number; d += 2 {
            n := d
            if d == 1 {
                n = 2
            }
            if number % n == 0 {
                diff_factors ++
                for number % n == 0 {
                    factors ++
                    number /= n
                }
            }
        }

        //
        // And this point, number is either 1 or a large prime, not encountered
        // before. In the later case, add one of the number of factors and
        // unique factors.
        //
        if number != 1 {
            diff_factors ++
            factors ++
        }

        switch mode {
            case 0: fmt . Println (diff_factors)
            case 1: fmt . Println      (factors)
        }
    }
}
