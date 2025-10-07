//# https://theweeklychallenge.org/blog/perl-weekly-challenge-342/
/*#

Task 1: Balance String

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string made up of lowercase English letters and digits
   only.

   Write a script to format the give string where no letter is followed by
   another letter and no digit is followed by another digit. If there are
   multiple valid rearrangements, always return the lexicographically
   smallest one. Return empty string if it is impossible to format the
   string.

Example 1

Input: $str = "a0b1c2"
Output: "0a1b2c"

Example 2

Input: $str = "abc12"
Output: "a1b2c"

Example 3

Input: $str = "0a2b1c3"
Output: "0a1b2c3"

Example 4

Input: $str = "1a23"
Output: ""

Example 5

Input: $str = "ab123"
Output: "1a2b3"

Task 2: Max Score
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

func bs(str string) string {
	rs := append([]rune(str), '_')
	slices.Sort(rs)
	m := slices.Index(rs, '_')
	l := len(str)
	d := l - 2*m
	switch d {
	case -1, 0:
		copy(rs[m:], rs[m+1:])
	case 1:
		for i := range m + 1 {
			rs[i], rs[m+i+1] = rs[m+i+1], rs[i]
		}
	default:
		return ""
	}
	n := max(m+d, m)
	for i := 1; i < n; i++ {
		for j := i; j < n; j++ {
			rs[j], rs[n+j-i] = rs[n+j-i], rs[j]
		}
	}
	return string(rs[:l])
}

func main() {
	for _, data := range []struct {
		input, output string
	}{
		{"a0b1c2", "0a1b2c"},
		{"abc12", "a1b2c"},
		{"0a2b1c3", "0a1b2c3"},
		{"1a23", ""},
		{"ab123", "1a2b3"},
		{"abcdefg0123456", "0a1b2c3d4e5f6g"},
		{"abcdef0123456", "0a1b2c3d4e5f6"},
		{"abcdefg123456", "a1b2c3d4e5f6g"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(bs(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
