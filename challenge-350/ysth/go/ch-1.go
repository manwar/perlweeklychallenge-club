package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-350/#TASK1

import (
    "strconv"
    run "github.com/ysth/runweeklychallenge-go"
)

// find overlapping 3 character substrings with 3 unique characters
func GoodSubstrings(str string) (int) {
    count := 0
    runes := []rune(str)
    i := 0
    for i < len(runes)-2 {
        // need to compare all three characters to each other
        // start with the later two since that can let us skip checking a position
        if runes[i+1] == runes[i+2] {
            i += 2
        } else {
            if runes[i] != runes[i+1] && runes[i] != runes[i+2] {
                count++
            }
            i++
        }
    }
    return count
}

func main() {
    run.RunWeeklyChallenge(func(inputs any) (string, error) { return strconv.Itoa(GoodSubstrings(inputs.(string))), nil }, `"abcaefg"`, `{"type":"string"}`)
}
