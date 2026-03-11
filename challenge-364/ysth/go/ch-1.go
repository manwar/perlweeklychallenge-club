package main

// https://theweeklychallenge.org/blog/perl-weekly-challenge-364/#TASK1

import (
	run "github.com/ysth/runweeklychallenge-go"
	"strings"
)

func DecryptString(str string) string {
	var result strings.Builder
	runes := []rune(str)
	for i := 0; i < len(runes); i++ {
		ch := runes[i]
		if i+2 < len(runes) && runes[i+2] == '#' && runes[i+1] >= '0' &&
			(ch == '1' && runes[i+1] <= '9' || ch == '2' && runes[i+1] <= '6') {

			result.WriteRune('a' + (runes[i+1] - '0') + 10*(ch-'0') - 1)
			i += 2
		} else if ch >= '0' && ch <= '9' {
			result.WriteRune('a' + ch - '1')
		}
	}
	return result.String()
}

func main() {
	run.RunWeeklyChallenge(
		func(inputs any) (string, error) { return run.JSONEncode(DecryptString(inputs.(string))), nil },
		`"10#11#12"`,
		`{"type":"string"}`,
	)
}
