package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-357/#TASK2

import (
    "fmt"
    "math/big"
    "slices"
    run "github.com/ysth/runweeklychallenge-go"
)

func UniqueFractionGenerator(i int) []string {
    result := make([]*big.Rat, 0, i*i)
    for numerator := 1; numerator <= i; numerator++ {
        for denominator := 1; denominator <= i; denominator++ {
            result = append(result, big.NewRat(int64(numerator), int64(denominator)))
        }
    }
    slices.SortFunc(result, func(a, b *big.Rat) int { return a.Cmp(b) })
    stringResult := make([]string, 0)
    seen := map[string]bool{}
    for i := range result {
        stringFormat := fmt.Sprintf("%s/%s", result[i].Num(), result[i].Denom())
        if ! seen[stringFormat] {
            stringResult = append(stringResult, stringFormat)
        }
        seen[stringFormat] = true
    }
    return stringResult
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(UniqueFractionGenerator(int(inputs.(float64)))), nil },
        `3`,
        `{"type":"integer", "minimum":1}`,
    )
}
