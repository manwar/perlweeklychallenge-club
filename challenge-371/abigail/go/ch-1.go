package main

import (
    "fmt"
    "bufio"
    "os"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        //
        // Read a line of input
        //
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        //
        // Turn the line of input into an array of bytes. This if fine
        // as it's a given that the input is ASCII.
        //
        letters := [] byte (text)

        //
        // Find the position of the question mark, and set the values
        // we need to calculate the missing character
        //
        var base, from, to byte
        for i := 0; i <= 8; i += 2 {
            if letters [i] == '?' {
                switch {
                    case i <  4:
                        base = letters [i + 2]
                        from = letters [i + 6]
                        to   = letters [i + 4]
                    case i == 4:
                        base = letters [i + 2]
                        from = letters [i - 2]
                        to   = letters [i - 4]
                    case i >  4:
                        base = letters [i - 2]
                        from = letters [i - 6]
                        to   = letters [i - 4]
                }
                break
            }
        }

        //
        // Calculate the missing character and print it
        //
        fmt . Printf ("%c\n", base - from + to)
    }
}
