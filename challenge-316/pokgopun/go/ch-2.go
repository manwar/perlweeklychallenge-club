//# https://theweeklychallenge.org/blog/perl-weekly-challenge-316/
/*#

Task 2: Subsequence

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two string.

   Write a script to find out if one string is a subsequence of another.
A subsequence of a string is a new string that is formed from the original strin
g
by deleting some (can be none)  of the characters without disturbing the relativ
e
positions of the remaining characters.

Example 1

Input: $str1 = "uvw", $str2 = "bcudvew"
Output: true

Example 2

Input: $str1 = "aec", $str2 = "abcde"
Output: false

Example 3

Input: $str1 = "sip", $str2 = "javascript"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 13th April
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
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

type input struct {
	str1, str2 string
}

func (in input) process() bool {
	if len(in.str1) == 0 {
		return false
	}
	var b strings.Builder
	delim := ".*"
	for _, v := range in.str1 {
		b.WriteString(delim)
		b.WriteRune(v)
	}
	res, _ := regexp.MatchString(b.String()[len(delim):], in.str2)
	return res
}

func main() {
	for _, data := range []struct {
		input  input
		output bool
	}{
		{input{"uvw", "bcudvew"}, true},
		{input{"aec", "abcde"}, false},
		{input{"sip", "javascript"}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
