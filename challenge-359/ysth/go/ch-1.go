package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK1

import (
    "strconv"
    run "github.com/ysth/runweeklychallenge-go"
)

func DigitalRoot(i int) (int, int) {
    persistence := 0
    for i > 9 {
        persistence++
        sum := 0
        for _, digit := range strconv.Itoa(i) {
            sum += int(digit - '0')
        }
        i = sum
    }
    return persistence, i
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) {
            result := make([]int, 2)
            result[0], result[1] = DigitalRoot(int(inputs.(float64)))
            return run.JSONEncode(result), nil
        },
        `38`,
        `{"type": "integer", "minimum": 0}`,
    )
}
