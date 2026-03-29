package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "regexp"
    // "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }

        parts := strings . Split (strings . TrimSuffix (text, "\n"), " ")

        target, prefixes := parts [0], parts [1:]

        valid := 0

        for _, prefix := range prefixes {
            match, err := regexp . MatchString ("^" + prefix, target)
            if err != nil {
                panic ("Match errorred")
            }
            if match || prefix == `""` {
                valid ++
            }
        }
        fmt . Println (valid)
    }
}
