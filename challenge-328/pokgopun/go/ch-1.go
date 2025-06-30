//# https://theweeklychallenge.org/blog/perl-weekly-challenge-328/
/*#

Task 1: Replace all ?

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only lower case English letters and
   ?.

   Write a script to replace all ? in the given string so that the string
   doesn’t contain consecutive repeating characters.

Example 1

Input: $str = "a?z"
Output: "abz"

There can be many strings, one of them is "abz".
The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace the '?'
.

Example 2

Input: $str = "pe?k"
Output: "peak"

Example 3

Input: $str = "gra?te"
Output: "grabte"

Task 2: Good String
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type input string

func (in input) process() string {
	rs := []rune(in)
	l := len(rs)
	for i := range l {
		var s []rune
		if rs[i] == '?' {
			if i > 0 {
				prv := rs[i-1]
				if prv != '?' {
					s = append(s, prv)
				}
			}
			if i < l-1 {
				nxt := rs[i+1]
				if nxt != '?' {
					s = append(s, nxt)
				}
			}
			for r := 'a'; r <= 'z'; r++ {
				if !slices.Contains(s, r) {
					rs[i] = r
					break
				}
			}
		}
	}
	return string(rs)
}

func main() {
	for _, data := range []struct {
		input  input
		output string
	}{
		{"a?z", "abz"},
		{"pe?k", "peak"},
		{"gra?te", "grabte"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
