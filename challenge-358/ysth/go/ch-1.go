package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-358/#TASK1

import (
    "regexp"
    "strconv"
    run "github.com/ysth/runweeklychallenge-go"
)

var allDigits = regexp.MustCompile(`^[0-9]+\z`)

func MaxStrValue(strings []string) (int, error) {
    maxValue := 0
    for _, s := range strings {
        var value int
        if allDigits.MatchString(s) {
            // all digits, but still could be larger than an int, bail if so
            var err error
            value, err = strconv.Atoi(s)
            if err != nil {
                return 0, err
            }
        } else {
            value = len([]rune(s))
        }
        if value > maxValue {
            maxValue = value
        }
    }
    return maxValue, nil
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) {
            maxValue, err := MaxStrValue(run.InputsAsStringSlice(inputs))
            if err != nil {
                return "", err
            } else {
                return run.JSONEncode(maxValue), nil
            }
        },
        `["123", "45", "6"]`,
        `{"type": "array", "items": {"type": "string"}}`,
    )
}
