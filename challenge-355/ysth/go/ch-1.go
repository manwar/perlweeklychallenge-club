package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK1

import (
    humanize "github.com/dustin/go-humanize"
    run "github.com/ysth/runweeklychallenge-go"
)

func ThousandSeparator(i int64) string {
    return humanize.Comma(i)
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(ThousandSeparator(int64(inputs.(float64)))), nil },
        `123`,
        `{"type": "integer", "minimum": 1}`,
    )
}
