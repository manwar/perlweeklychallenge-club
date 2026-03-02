package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK2

import (
    "slices"
    "strings"
    "github.com/divan/num2words"
    run "github.com/ysth/runweeklychallenge-go"
)

func SpellboundSorting(integers []int) []int {
    result := slices.Clone(integers)
    slices.SortFunc(result, func(a int, b int) int { return strings.Compare(num2words.Convert(a), num2words.Convert(b)) })
    return result
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(SpellboundSorting(run.InputsAsIntSlice(inputs))), nil },
        `[6, 7, 8, 9, 10]`,
        `{"type":"array", "items": {"type":"integer"}}`,
    )
}
