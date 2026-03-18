package main

//
// See https://theweeklychallenge.org/blog/perl-weekly-challenge-365
//

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    "regexp"
)


func main () {
    var reader = bufio . NewReader (os. Stdin)
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        var tokens = strings . Split (strings . TrimSpace (text), " ")
        var valid  = 0
        for _, token := range tokens {
            var matched, _ =
                regexp . MatchString (`^([a-z]+(-[a-z]+)?)?[!.,]?$`, token)
            if (matched) {
                valid = valid + 1
            }
        }
        fmt . Printf ("%d\n", valid)
    }
}
