package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK2

import (
    "cmp"
    run "github.com/ysth/runweeklychallenge-go"
)

// true if integers in ints monotonically increase then decrease
func MountainArray(ints []int) bool {
    length := len(ints)
    if length < 3 || ints[0] >= ints[1] || ints[length-2] <= ints[length-1] {
        return false
    }

    direction := 1
    for i := length - 2; i > 1; i-- {
        newDirection := cmp.Compare(ints[i-1], ints[i]);
        if direction != newDirection {
            if direction == 1 && newDirection == -1 {
                direction = -1
            } else {
                return false
            }
        }
    }
    return true
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(MountainArray(run.InputsAsIntSlice(inputs))), nil },
        `[1, 2, 3, 4, 5]`,
        `{"type":"array", "items": {"type": "integer"}}`,
    )
}
