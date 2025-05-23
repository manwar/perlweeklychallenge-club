//# https://theweeklychallenge.org/blog/perl-weekly-challenge-322/
/*#

Task 1: String Format

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string and a positive integer.

   Write a script to format the string, removing any dashes, in groups of
   size given by the integer. The first group can be smaller than the
   integer but should have at least one character. Groups should be
   separated by dashes.

Example 1

Input: $str = "ABC-D-E-F", $i = 3
Output: "ABC-DEF"

Example 2

Input: $str = "A-BC-D-E", $i = 2
Output: "A-BC-DE"

Example 3

Input: $str = "-A-B-CD-E", $i = 4
Output: "A-BCDE"

Task 2: Rank Array
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type input struct {
	str string
	i   int
}

func (in input) process() string {
	var (
		b  byte
		bs []byte
	)
	sep := byte('-')
	i := len(in.str)
	l := 0
	for i > 0 {
		i--
		b = in.str[i]
		if b == sep {
			continue
		}
		if l < in.i {
			bs = append(bs, b)
			l++
		} else {
			bs = append(bs, sep, b)
			l = 1
		}
	}
	slices.Reverse(bs)
	return string(bs)
}

func main() {
	for _, data := range []struct {
		input  input
		output string
	}{
		{input{"ABC-D-E-F", 3}, "ABC-DEF"},
		{input{"A-BC-D-E", 2}, "A-BC-DE"},
		{input{"-A-B-CD-E", 4}, "A-BCDE"},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
