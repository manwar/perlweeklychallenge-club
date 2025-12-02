//# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/
/*#

Task 1: Good Substrings

Submitted by: [51]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to return the number of good substrings of length three
   in the given string.

     A string is good if there are no repeated characters.

Example 1

Input: $str = "abcaefg"
Output: 5

Good substrings of length 3: abc, bca, cae, aef and efg

Example 2

Input: $str = "xyzzabc"
Output: 3

Good substrings of length 3: "xyz", "zab" and "abc"

Example 3

Input: $str = "aababc"
Output: 1

Good substrings of length 3: "abc"

Example 4

Input: $str = "qwerty"
Output: 4

Good substrings of length 3: "qwe", "wer", "ert" and "rty"

Example 5

Input: $str = "zzzaaa"
Output: 0

Task 2: Shuffle Pairs
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func rUniq(rs []rune) bool {
	m := make(map[rune]int)
	for _, v := range rs {
		m[v]++
		if m[v] > 1 {
			return false
		}
	}
	return true
}

func gs(str string) int {
	n := 3
	rs := []rune(str)
	lmt := len(rs) - n + 1
	i := 0
	c := 0
	for i < lmt {
		if rUniq(rs[i : i+n]) {
			c++
		}
		i++
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"abcaefg", 5},
		{"xyzzabc", 3},
		{"aababc", 1},
		{"qwerty", 4},
		{"zzzaaa", 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(gs(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
