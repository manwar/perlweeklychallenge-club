package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-357/#TASK1

import (
    "fmt"
    "slices"
    "strconv"
    run "github.com/ysth/runweeklychallenge-go"
)

func KaprekarConstant(i int) int {
    seen := map[int]bool{i: true}
    iterations := 0
    for i != 6174 {
        digits := []byte(fmt.Sprintf("%04d", i))
        slices.Sort(digits)
        lower, _ := strconv.Atoi(string(digits))
        slices.Reverse(digits)
        higher, _ := strconv.Atoi(string(digits))
        i = higher - lower
        if seen[i] {
            return -1
        }
        seen[i] = true
        iterations++
    }
    return iterations
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(KaprekarConstant(int(inputs.(float64)))), nil },
        `3524`,
        `{"type": "integer", "minimum": 0, "maximum": 9999}`,
    )
}
