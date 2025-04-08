//# https://theweeklychallenge.org/blog/perl-weekly-challenge-316/
/*#

Task 1: Circular

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words.

   Write a script to find out whether the last character of each word is
   the first character of the following word.

Example 1

Input: @list = ("perl", "loves", "scala")
Output: true

Example 2

Input: @list = ("love", "the", "programming")
Output: false

Example 3

Input: @list = ("java", "awk", "kotlin", "node.js")
Output: true

Task 2: Subsequence
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type strings []string

func (ss strings) process() bool {
	l := len(ss)
	if l < 2 {
		return false
	}
	for i := range l - 1 {
		if ss[i][len(ss[i])-1] != ss[i+1][0] {
			return false
		}
	}
	return true
}

func main() {
	for _, data := range []struct {
		input  strings
		output bool
	}{
		{strings{"perl", "loves", "scala"}, true},
		{strings{"love", "the", "programming"}, false},
		{strings{"java", "awk", "kotlin", "node.js"}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
