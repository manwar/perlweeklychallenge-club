//# https://theweeklychallenge.org/blog/perl-weekly-challenge-320/
/*#

Task 1: Maximum Count

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return the maximum between the number of positive and
   negative integers. Zero is neither positive nor negative.

Example 1

Input: @ints = (-3, -2, -1, 1, 2, 3)
Output: 3

There are 3 positive integers.
There are 3 negative integers.
The maximum between 3 and 3 is 3.

Example 2

Input: @ints = (-2, -1, 0, 0, 1)
Output: 2

There are 1 positive integers.
There are 2 negative integers.
The maximum between 2 and 1 is 2.

Example 3

Input: @ints = (1, 2, 3, 4)
Output: 4

There are 4 positive integers.
There are 0 negative integers.
The maximum between 4 and 0 is 4.

Task 2: Sum Difference
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type input []int

func (in input) process() int {
	var cntn, cntp int
	for _, v := range in {
		switch {
		case v < 0:
			cntn++
		case v > 0:
			cntp++
		}
	}
	return max(cntn, cntp)
}

func main() {
	for _, data := range []struct {
		input  input
		output int
	}{
		{input{-3, -2, -1, 1, 2, 3}, 3},
		{input{-2, -1, 0, 0, 1}, 2},
		{input{1, 2, 3, 4}, 4},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise the differences
	}
}
