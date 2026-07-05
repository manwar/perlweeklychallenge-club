package main

import (
    "fmt"
    "bufio"
    "os"
    // "strings"
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
        var chars ['z' - 'a' + 1] int;
        for i := 'a'; i <= 'z'; i ++ {
            chars [i - 'a'] = 0;
        }

        for i := 0; i < len (text); i ++ {
            ch := text [i]
            if 'a' <= ch && ch <= 'z' {
                chars [ch - 'a'] ++
            }
        }

        max_c := 0
        max_v := 0

        for ch := 'a'; ch <= 'z'; ch ++ {
            cmp := & max_c
            if ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u' {
                cmp = & max_v
            }
            if * cmp < chars [ch - 'a'] {
                * cmp = chars [ch - 'a']
            }
        }
        fmt . Printf ("%d\n", max_c + max_v)
    }
}
