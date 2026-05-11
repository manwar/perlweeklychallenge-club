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
        chars := [] rune (text)                     // Slice of characters
        max   := -1                                 // Track max difference.

        for f := 0; f < len (chars) - 2; f ++ {     // For all non-nl characters
            for l := len (chars) - 2; l > f; l -- { // find matching character
                if chars [f] == chars [l] {         // from the end
                    if l - f - 1 > max {            // If larger distance, ...
                        max = l - f - 1             // remember it
                    }
                    break
                }
            }
        }

        fmt . Println (max)
    }
}
