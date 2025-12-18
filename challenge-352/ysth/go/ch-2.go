package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-352/#TASK2

import (
    "strconv"
    "strings"
    run "github.com/ysth/runweeklychallenge-go"
)

func BinaryPrefix(nums []int) []bool {
    var result = make([]bool, 0, len(nums))
    num := 0
    for _, i := range nums {
        num = num * 2 + i
        result = append(result, num % 5 == 0)
    }
    return result
}

func main() {
    run.RunWeeklyChallenge(
        func(inputs any) (string, error) {
            var b strings.Builder
            b.WriteString("(")
            for i, value := range BinaryPrefix(run.InputsAsIntSlice(inputs)) {
                if i > 0 {
                    b.WriteString(", ")
                }
                b.WriteString(strconv.FormatBool(value))
            }
            b.WriteString(")")
            return b.String(), nil
        },
        `[0,1,1,0,0,1,0,1,1,1]`,
        `{"type":"array", "items": {"type": "integer", "minimum": 0, "maximum": 1}}`,
    )
}
