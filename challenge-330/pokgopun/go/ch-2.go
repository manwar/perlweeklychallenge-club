//# https://theweeklychallenge.org/blog/perl-weekly-challenge-330/
/*#

Task 2: Title Capital

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string made up of one or more words separated by a
   single space.

   Write a script to capitalise the given title. If the word length is 1
   or 2 then convert the word to lowercase otherwise make the first
   character uppercase and remaining lowercase.

Example 1

Input: $str = "PERL IS gREAT"
Output: "Perl is Great"

Example 2

Input: $str = "THE weekly challenge"
Output: "The Weekly Challenge"

Example 3

Input: $str = "YoU ARE A stAR"
Output: "You Are a Star"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 20th July 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strings"

	"github.com/google/go-cmp/cmp"
)

func tc(str string) string {
	var b strings.Builder
	for v := range strings.SplitSeq(strings.ToLower(str), " ") {
		b.WriteRune(' ')
		if len(v) > 2 {
			b.WriteString(strings.ToUpper(v[:1]) + v[1:])
		} else {
			b.WriteString(v)
		}
	}
	return b.String()[1:]
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"PERL IS gREAT", "Perl is Great"},
		{"THE weekly challenge", "The Weekly Challenge"},
		{"YoU ARE A stAR", "You Are a Star"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(tc(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
