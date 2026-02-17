package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK2

import (
    "strings"
    "github.com/patrickmn/sortutil"
    run "github.com/ysth/runweeklychallenge-go"
)

func WordSorter(sentence string) string {
    words := strings.Split(sentence, " ")
    // eliminate trailing/double spaces
    var keep int
    for _, word := range words {
        if word != "" {
            words[keep] = word
            keep++
        }
    }
    words = words[0:keep]
    sortutil.CiAsc(words)
    return strings.Join(words, " ")
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(WordSorter(inputs.(string))), nil },
        `"The quick brown fox"`,
        `{"type":"string"}`,
    )
}
