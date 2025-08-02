//# https://theweeklychallenge.org/blog/perl-weekly-challenge-329/
/*#

Task 2: Nice String

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string made up of lower and upper case English letters
   only.

   Write a script to return the longest substring of the give string which
   is nice. A string is nice if, for every letter of the alphabet that the
   string contains, it appears both in uppercase and lowercase.

Example 1

Input: $str = "YaaAho"
Output: "aaA"

Example 2

Input: $str = "cC"
Output: "cC"

Example 3

Input: $str = "A"
Output: ""

No nice string found.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 13th July 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type str string

func (s str) process() str {
	var out str
	l := len(s) - 1
	i := l
	start := l - i
	for i > 0 {
		i--
		idx := l - i
		a, b := s[idx], s[idx-1]
		d := max(a, b) - min(a, b)
		if d == 0 || d == 32 {
			continue
		} else {
			cdd := s[start:idx]
			if len(cdd) > len(out) && len(slices.Compact([]byte(cdd))) > 1 {
				out = cdd
			}
			start = idx
		}
	}
	if i == 0 {
		cdd := s[start:]
		if len(cdd) > len(out) && len(slices.Compact([]byte(cdd))) > 1 {
			out = cdd
		}
	}
	return out
}

func main() {
	for _, data := range []struct {
		input, output str
	}{
		{"YaaAho", "aaA"},
		{"YaaAhoooo", "aaA"},
		{"YaaAhoOOo", "oOOo"},
		{"YaaAhooO", "aaA"},
		{"cC", "cC"},
		{"cc", ""},
		{"A", ""},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
