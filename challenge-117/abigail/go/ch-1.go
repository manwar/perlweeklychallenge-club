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
    var i      int
    var sum    int = 0
    var SUM_15 int = 120

    var reader = bufio . NewReader (os. Stdin)
    for {
        var text, err1 = reader . ReadString ('\n')
        if (err1 != nil) {
            //
            // Break the loop on error -- EOF is an error
            //
            break
        }
        //
        // Atoi isn't like atoi in C, so we use Sscanf
        //
        var n, err2 = fmt . Sscanf (text, "%d", &i)
        if (n < 1 || err2 != nil) {
            //
            // If we can't scan, ignore the line
            //
            continue
        }
        //
        // Tally the line numbers
        //
        sum += i
    }
    //
    // Missing line number is 120 minus the tally
    //
    fmt . Printf ("%d\n", SUM_15 - sum)
}
