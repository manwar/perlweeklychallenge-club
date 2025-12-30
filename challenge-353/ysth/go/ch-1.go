package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK1

import (
    "regexp"
    "strconv"
    run "github.com/ysth/runweeklychallenge-go"
)

// for our purposes here, a word is a group of non-space characters that includes a number or letter
var word = regexp.MustCompile(`\S*?[\p{L}\p{N}]\S*`)

// Given a slice of sentence strings, return the maximum number of words that appear in a single sentence.
func MaxWords(sentences []string) int {
    var maxWords = 0
    for _, sentence := range sentences {
        var words = len(word.FindAll([]byte(sentence), -1))
        if words > maxWords {
            maxWords = words
        }
    }

    return maxWords
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) {
            return strconv.Itoa(MaxWords(run.InputsAsStringSlice(inputs))), nil
        },
        `["Hello world", "This is a test", "Perl is great"]`,
        `{"type":"array", "items": {"type": "string"}}`,
    )
}
