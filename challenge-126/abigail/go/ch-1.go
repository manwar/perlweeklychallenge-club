package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go
//

import (
    "fmt"
    "bufio"
    "os"
)

func main () {
    var reader = bufio . NewReader (os. Stdin)
    for {
        var text, err = reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        result   := 0
        seen_one := false
        for _, digit := range text {
            if digit < '0' || digit > '9' {
                continue
            }
            result = 9 * result
            if seen_one {
                result += 8
            } else if digit == '1' {
                seen_one = true
            } else if digit != '0' {
                result = result + int (digit - '0') - 1
            }
        }
        fmt . Println (result)
    }
}
