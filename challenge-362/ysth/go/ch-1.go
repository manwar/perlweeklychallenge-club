package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK1

import (
    "strings"
    run "github.com/ysth/runweeklychallenge-go"
)

func EchoChamber(str string) string {
    var result strings.Builder
    for index, character := range str {
        for range index+1 {
            result.WriteRune(character)
        }
    }
    return result.String()
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(EchoChamber(inputs.(string))), nil },
        `"abca"`,
        `{"type":"string", "pattern":"^\\p{Ll}+$"}`,
    )
}
