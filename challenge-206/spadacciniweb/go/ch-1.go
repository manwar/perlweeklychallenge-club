/*
Task 1: Shortest Time
Submitted by: Mohammad S Anwar

You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.
Write a script to find out the shortest time in minutes between any two time points.

Example 1
Input: @time = ("00:00", "23:55", "20:00")
Output: 5

Since the difference between "00:00" and "23:55" is the shortest (5 minutes).

Example 2
Input: @array = ("01:01", "00:50", "00:57")
Output: 4

Example 3
Input: @array = ("10:10", "09:30", "09:00", "09:55")
Output: 15
*/

package main

import (
    "fmt"
    "log"
    "os"
    "strconv"
    "gonum.org/v1/gonum/stat/combin"
)

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func getDistanceMinutes(m1 int, m2 int) int {
    var dist = abs(m1 - m2)
    if dist >= 720 {        // 12 hh * 60 = minutes
        return 1440 - dist  // 24 hh * 60 = minutes
    }
    return dist
}

func getMinutes(hhmm string) int {
    hh, mm := hhmm[0:2], hhmm[3:5]
    hhInt, err := strconv.Atoi(hh)
    if (err != nil) {
        log.Fatal(err)
    }
    mmInt, err := strconv.Atoi(mm)
    if (err != nil) {
        log.Fatal(err)
    }
    return (hhInt % 24) * 60 + mmInt
}

func main() {
    arrStr := os.Args[1:]
    if (len(arrStr) < 2) {
        log.Fatal("input error")
    }

    minutes := make([]int, len(arrStr))
    for i := 0; i <= len(arrStr)-1; i++ {
        minutes[i] = getMinutes(arrStr[i])
    }

    var minPointer *int
    var pair [2]string
    cs := combin.Combinations(len(minutes), 2)
    for _, c := range cs {
        var dist = getDistanceMinutes(minutes[c[0]], minutes[c[1]])
        if minPointer == nil || *minPointer > dist {
            minPointer = &dist
            pair[0] = arrStr[c[0]]
            pair[1] = arrStr[c[1]]
        }
    }

    fmt.Printf("Output: %d", *minPointer)
    fmt.Printf("\nSince the difference between \"%s\" and \"%s\" is the shortest (%d minutes).\n", pair[0], pair[1], *minPointer)
}
