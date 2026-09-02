package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "regexp"
    "strconv"
)

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        numbers := strings . Fields (strings . TrimSpace (text))
        pat := ""
        for index, _ := range (numbers) {
            if index > 0 {
                left,  _ := strconv . Atoi (numbers [index - 1])
                right, _ := strconv . Atoi (numbers [index])
                if left <  right {pat = pat + "2"}
                if left == right {pat = pat + "1"}
                if left >  right {pat = pat + "0"}
            }
        }
        matches := regexp . MustCompile (`0?(20)*2?`) . FindAllString (pat, -1)
        max := 1
        for _, match := range (matches) {
            if len (match) >= max {
                max = 1 + len (match)
            }
        }

        fmt . Printf ("%d\n", max)
    }
}
