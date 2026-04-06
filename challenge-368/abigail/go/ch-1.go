package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    // "regexp"
    // "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        //
        // Parse the input; split into the target string and the digit.
        // Remember to strip off the trailing newline.
        //
        parts := strings . Split      (text,      " ")
        chars := strings . Split      (parts [0], "")
        digit := strings . TrimSuffix (parts [1], "\n")

        //
        // Find the first occurrence of the digit, followed by the a
        // digit which is larger. When found, replace it with an
        // empty string, and break the loop.
        //
        matched := false
        for i := 0; i < len (chars) - 1; i ++ {
            if chars [i] == digit && chars [i + 1] > digit {
                chars [i] = ""
                matched = true
                break
            }
        }

        //
        // If we didn't replace something in the first loop, find the
        // last digit in the string. Replace said digit with an empty
        // string.
        //
        if !matched {
            for i := len (chars) - 1; i >= 0; i -- {
                if chars [i] == digit {
                    chars [i] = ""
                    break
                }
            }
        }

        //
        // Print the result
        //
        fmt . Println (strings . Join (chars, ""))
    }
}
