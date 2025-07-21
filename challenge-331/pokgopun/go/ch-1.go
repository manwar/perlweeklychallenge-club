//# https://theweeklychallenge.org/blog/perl-weekly-challenge-331/
/*#

Task 1: Last Word

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to find the length of last word in the given string.

Example 1

Input: $str = "The Weekly Challenge"
Output: 9

Example 2

Input: $str = "   Hello   World    "
Output: 5

Example 3

Input: $str = "Let's begin the fun"
Output: 3

Task 2: Buddy Strings
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"regexp"

	"github.com/google/go-cmp/cmp"
)

func lw(str string) int {
	idx := regexp.MustCompile(`(\S+)\s*$`).FindStringSubmatchIndex(str)
	return idx[3] - idx[2]
}

func main() {
	for _, data := range []struct {
		input  string
		output int
	}{
		{"The Weekly Challenge", 9},
		{"   Hello   World    ", 5},
		{"Let's begin the fun", 3},
	} {
		io.WriteString(os.Stdout, cmp.Diff(lw(data.input), data.output)) // blank if ok, otherwise show the difference
	}
}
