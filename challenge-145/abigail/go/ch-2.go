package main

//
// See ../README.md
//

//
// Run as: go run ch-2.go
//

import (
    "fmt"
    "bufio"
    "os"
)

func is_palindrome (str string) bool {
    runes := [] rune (str)
    for i, j := 0, len (runes) - 1; i < j; i, j = i + 1, j - 1 {
        if runes [i] != runes [j] {
            return false
        }
    }
    return true
}

func main () {
    var reader = bufio . NewReader (os. Stdin)
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        palindromes := make (map [string] bool)
        for i := 0; i < len (text) - 1; i ++ {
            for j := i; j < len (text) - 1; j ++ {
                substr := text [i : j + 1]
                if is_palindrome (substr) {
                    palindromes [substr] = true
                }
            }
        }
        for k := range palindromes {
            fmt . Printf ("%s ", k)
        }
        fmt . Println ("")
    }
}
