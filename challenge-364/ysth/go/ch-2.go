package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-364/#TASK2

import (
	run "github.com/ysth/runweeklychallenge-go"
	"strings"
)

func GoalParser(str string) string {
	var result strings.Builder
	runes := []rune(str)
	for i := 0; i < len(runes); i++ {
		switch runes[i] {
		case 'G':
			result.WriteRune('G')
		case '(':
			if i+1 < len(runes) && runes[i+1] == ')' {
				result.WriteRune('o')
				i++
			} else if i+3 < len(runes) && string(runes[i+1:i+4]) == "al)" {
				result.WriteString("al")
				i += 3
			}
		}
	}
	return result.String()
}

func main() {
	run.RunWeeklyChallenge(
		func(inputs any) (string, error) { return run.JSONEncode(GoalParser(inputs.(string))), nil },
		`"G()(al)"`,
		`{"type":"string"}`,
	)
}
