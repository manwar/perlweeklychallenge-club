//# https://theweeklychallenge.org/blog/perl-weekly-challenge-317/
/*#

Task 2: Friendly Strings

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings.

   Write a script to return true if swapping any two letters in one string
   match the other string, return false otherwise.

Example 1

Input: $str1 = "desc", $str2 = "dsec"
Output: true

Example 2

Input: $str1 = "fuck", $str2 = "fcuk"
Output: true

Example 3

Input: $str1 = "poo", $str2 = "eop"
Output: false

Example 4

Input: $str1 = "stripe", $str2 = "sprite"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 20th April
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type input struct {
	str1, str2 string
}

type bytePair struct {
	a, b byte
}

func (in input) process() bool {
	str1, str2 := in.str1, in.str2
	l := len(str1)
	if l != len(str2) {
		return false
	}
	var (
		bpp [2]bytePair
		c   int
	)
	for i := range l {
		bp := bytePair{str1[i], str2[i]}
		if bp.a != bp.b {
			if c == 2 {
				return false
			}
			bpp[c] = bp
			c++
		}
	}
	return c == 2 && bpp[0].a == bpp[1].b && bpp[0].b == bpp[1].a
}

func main() {
	for _, data := range []struct {
		input  input
		output bool
	}{
		{input{"desc", "dsec"}, true},
		{input{"fuck", "fcuk"}, true},
		{input{"poo", "eop"}, false},
		{input{"stripe", "sprite"}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
