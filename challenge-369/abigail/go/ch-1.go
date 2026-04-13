package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "regexp"
    // "strconv"
)

//
// Substitute the pattern inside string by replacement, globally
//
func sub (subject string, pattern string, replacement string) string {
    return regexp . MustCompile (pattern) .
                    ReplaceAllString (subject, replacement)
}

//
// Given a slice containing bytes, return a single element slice
// with the last element of the input upper cased (which can be done
// by subtracting 32).
//
func upper (match [] byte) [] byte {
    out := make ([] byte, 1, 1)
    out [0] = match [len (match) - 1] - 32
    return out
}

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        input, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        input = sub (input, "^\\s+", "")             // Remove leading space
        input = sub (input, "[^[:alpha:]\\s]+", "")  // Remove non-letters,
                                                     // but keep spaces
        input = sub (input, "\\s+$", "")             // Remove trailing space
        input = strings . ToLower (input)            // Lower case string

        //
        // Now we want to upper case each letter which is followed by a
        // space, while dropping the space. Go doesn't have "\u", and
        // using a function to calculate the replacement can only be
        // done if we're acting on bytes. So, we turn the string into 
        // an byte array, perform the substitution, and turn the resulting
        // byte array back into a string again -- with the leading '#' added.
        //
        bytes := [] byte (input)
        bytes  = regexp . MustCompile ("\\s+[[:alpha:]]") .
                          ReplaceAllFunc (bytes, upper)
        input  = "#" + string (bytes)

        //
        // Calculate how many characters we need to print. You can't address
        // outside of the length of the string, so we need to do some
        // calculation.
        //
        len := len (input)
        if len > 100 {
            len = 100
        }
        fmt . Println (input [0:len])
    }
}
