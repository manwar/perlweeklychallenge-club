package main

//
// See ../README.md
//

//
// Run as: go run ch-1.go < input-file
//

import (
    "fmt"
)

const SUNDAY    = 0
const MONDAY    = 1
const TUESDAY   = 2
const WEDNESDAY = 3
const THURSDAY  = 4
const FRIDAY    = 5
const SATURDAY  = 6

var lookup = [2] [7] int {
    {261, 261, 260, 260, 261, 261, 261},
    {262, 262, 261, 260, 261, 262, 262},
}

var anchors = [4] int {TUESDAY, SUNDAY, FRIDAY, WEDNESDAY}

func doomsday (year int) int {
    anchor := anchors [(year / 100) % 4]
    y      := year % 100
    return (((y / 12) + (y % 12) + ((y % 12) / 4)) + anchor) % 7
}

func is_leap (year int) int {
    if (year % 400 == 0) || (year % 4 == 0) && (year % 100 != 0) {
        return 1
    }
    return 0
}

func main () {
    for {
        var year int
        n, err := fmt . Scanf ("%d", &year)
        if (n != 1 || err != nil) {
            break
        }
        fmt . Println (lookup [is_leap (year)] [doomsday (year)])
    }
}
