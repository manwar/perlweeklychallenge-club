//# https://theweeklychallenge.org/blog/perl-weekly-challenge-331/
/*#

Task 2: Buddy Strings

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings, source and target.

   Write a script to find out if the given strings are Buddy Strings.
If swapping of a letter in one string make them same as the other then they are
`Buddy Strings`.

Example 1

Input: $source = "fuck"
       $target = "fcuk"
Output: true

The swapping of 'u' with 'c' makes it buddy strings.

Example 2

Input: $source = "love"
       $target = "love"
Output: false

Example 3

Input: $source = "fodo"
       $target = "food"
Output: true

Example 4

Input: $source = "feed"
       $target = "feed"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 27th July 2025.
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

type input struct {
	source, target string
}

func (in input) process() bool {
	l := len(in.source)
	if l != len(in.target) {
		return false
	}
	s := []byte(in.source)
	slices.Sort(s)
	s = slices.Compact(s)
	if in.source == in.target {
		if l != len(s) {
			return true
		} else {
			return false
		}
	}
	var swp []byte
	for i := range l {
		a, b := in.source[i], in.target[i]
		if a != b {
			swp = append(swp, a, b)
		}
		if len(swp) == 4 {
			if swp[0] == swp[3] && swp[1] == swp[2] {
				return in.source[i+1:] == in.target[i+1:]
			}
		}
	}
	return false
}

func main() {
	for _, data := range []struct {
		input  input
		output bool
	}{
		{input{"fuck", "fcuk"}, true},
		{input{"love", "love"}, false},
		{input{"fodo", "food"}, true},
		{input{"feed", "feed"}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
