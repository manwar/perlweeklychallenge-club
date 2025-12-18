package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-352/#TASK1

import (
    "fmt"
    "strings"
    run "github.com/ysth/runweeklychallenge-go"
)

func MatchString(words []string) []string {
    var result = make([]string, 0, len(words))
    found := map[string]bool{}
    for i, s := range words {
        if found[s] {
            continue
        }
        for j, s2 := range words {
            if i != j && strings.Contains(s2, s) {
                found[s] = true
                result = append(result, s)
                break
            }
        }
    }
    return result
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) {
            var b strings.Builder
            b.WriteString("(")
            for i, value := range MatchString(run.InputsAsStringSlice(inputs)) {
                if i > 0 {
                    b.WriteString(", ")
                }
                b.WriteString(fmt.Sprintf(`"%s"`, value))
            }
            b.WriteString(")")
            return b.String(), nil
        },
        `["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"]`,
        `{"type":"array", "items": {"type": "string"}}`,
    )
}
