package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-359/#TASK2

import (
    run "github.com/ysth/runweeklychallenge-go"
)

func StringReduction(word string) string {
    characters := []rune(word)
    num_characters := len(characters)
    num_kept := 0
    i := 0
    for i < num_characters {
        if i + 1 < num_characters && characters[i] == characters[i+1] {
            i += 2
        } else if num_kept > 0 && characters[i] == characters[num_kept-1] {
            i++
            num_kept--
        } else {
            characters[num_kept] = characters[i]
            num_kept++
            i++
        }
    }

    return string(characters[0:num_kept])
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) { return run.JSONEncode(StringReduction(inputs.(string))), nil },
        `"aabbccdd"`,
        `{"type":"string"}`,
    )
}
