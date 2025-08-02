//# https://theweeklychallenge.org/blog/perl-weekly-challenge-311/
/*#

Task 1: Upper Lower

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string consists of english letters only.

   Write a script to convert lower case to upper and upper case to lower
   in the given string.

Example 1

Input: $str = "pERl"
Output: "PerL"

Example 2

Input: $str = "rakU"
Output: "RAKu"

Example 3

Input: $str = "PyThOn"
Output: "pYtHoN"

Task 2: Group Digit Sum
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func ul(str string) string {
	o := 'a' - 'A'
	var b strings.Builder
	for _, r := range str {
		switch {
		case r >= 'A' && r <= 'Z':
			r += o
		case r >= 'a' && r <= 'z':
			r -= o
		}
		b.WriteRune(r)
	}
	return b.String()
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"pERl", "PerL"},
		{"rakU", "RAKu"},
		{"PyThOn", "pYtHoN"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(ul(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
