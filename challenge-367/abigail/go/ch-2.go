package main

import (
    "fmt"
    "bufio"
    "os"
    "strings"
    // "regexp"
    "strconv"
)

func tcmp (t1 [2] int, t2 [2] int) int {
    if t1 [0] < t2 [0] {return -1}
    if t1 [0] > t2 [0] {return  1}
    if t1 [1] < t2 [1] {return -1}
    if t1 [1] > t2 [1] {return  1}
    return 0
}

func main () {
    reader := bufio . NewReader (os . Stdin)
    for {
        var b1 [2] int
        var e1 [2] int
        var b2 [2] int
        var e2 [2] int

        //
        // Read a line of input
        //
        text, err := reader . ReadString ('\n')
        if (err != nil) {
            break
        }
        
        //
        // Parse input
        //
        text = strings . TrimSuffix (text, "\n")
        parts := strings . Split (text, " ")
        b1s := strings . Split (parts [0], ":")
        e1s := strings . Split (parts [1], ":")
        b2s := strings . Split (parts [2], ":")
        e2s := strings . Split (parts [3], ":")

        b1 [0], _ = strconv . Atoi (b1s [0])
        b1 [1], _ = strconv . Atoi (b1s [1])
        e1 [0], _ = strconv . Atoi (e1s [0])
        e1 [1], _ = strconv . Atoi (e1s [1])
        b2 [0], _ = strconv . Atoi (b2s [0])
        b2 [1], _ = strconv . Atoi (b2s [1])
        e2 [0], _ = strconv . Atoi (e2s [0])
        e2 [1], _ = strconv . Atoi (e2s [1])

        //
        // Do we straddle midnight
        //
        straddle1 := tcmp (b1, e1) > 0
        straddle2 := tcmp (b2, e2) > 0

        var intersect bool
        switch {
            case straddle1 && straddle2:
                intersect = true
            case straddle1:
                intersect = !(tcmp (b1, e2) >= 0 && tcmp (e1, b2) <= 0)
            case straddle2:
                intersect = !(tcmp (b2, e1) >= 0 && tcmp (e2, b1) <= 0)
            default:
                intersect = !(tcmp (e2, b1) <= 0 || tcmp (b2, e1) >= 0)
        }
        switch intersect {
            case true:  fmt . Println ("true")
            case false: fmt . Println ("false")
        }
    }
}
