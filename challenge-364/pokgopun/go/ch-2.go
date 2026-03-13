//# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/
/*#

Task 2: Goal Parser

Submitted by: [66]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a script to interpret the given string using Goal Parser.

     The Goal Parser interprets “G” as the string “G”, “()” as the string
     “o”, and “(al)” as the string “al”. The interpreted strings are then
     concatenated in the original order.

Example 1

Input: $str = "G()(al)"
Output: "Goal"

G    -> "G"
()   -> "o"
(al) -> "al"

Example 2

Input: $str = "G()()()()(al)"
Output: "Gooooal"

G       -> "G"
four () -> "oooo"
(al)    -> "al"

Example 3

Input: $str = "(al)G(al)()()"
Output: "alGaloo"

(al) -> "al"
G    -> "G"
(al) -> "al"
()   -> "o"
()   -> "o"

Example 4

Input: $str = "()G()G"
Output: "oGoG"

() -> "o"
G  -> "G"
() -> "o"
G  -> "G"

Example 5

Input: $str = "(al)(al)G()()"
Output: "alalGoo"

(al) -> "al"
(al) -> "al"
G    -> "G"
()   -> "o"
()   -> "o"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 15th March
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"regexp"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func main() {
	rgx := regexp.MustCompile(`G|\(\)|\(al\)`)
	f := func(str string) string {
		var b strings.Builder
		i := 0
		for {
			loc := rgx.FindStringIndex(str[i:])
			if loc == nil {
				break
			}
			switch loc[1] - loc[0] {
			case 1:
				b.WriteRune('G')
			case 2:
				b.WriteRune('o')
			default:
				b.WriteString("al")
			}
			i += loc[1]
		}
		return b.String()
	}
	for _, data := range []struct {
		input, output string
	}{
		{"G()(al)", "Goal"},
		{"G()()()()(al)", "Gooooal"},
		{"(al)G(al)()()", "alGaloo"},
		{"()G()G", "oGoG"},
		{"(al)(al)G()()", "alalGoo"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(f(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
