package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-349/#TASK1

import (
    "strconv"
    run "github.com/ysth/runweeklychallenge-go"
)

// find length of longest character repetition
func PowerOfString(str string) (int) {
    power, lastLength, lastRune:= 0, 0, ' '
    for _, r := range str {
        if r == lastRune {
            lastLength++
        } else {
            if lastLength > power {
                power = lastLength
            }
            lastRune = r
            lastLength = 1
        }
    }
    if lastLength > power {
        power = lastLength
    }
    return power
}

func main() {
    run.RunWeeklyChallenge(func(inputs any) (string, error) { return strconv.Itoa(PowerOfString(inputs.(string))), nil }, `"textbook"`, `{"type":"string","minLength":1}`)
}
