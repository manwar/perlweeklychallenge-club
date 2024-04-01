//# https://theweeklychallenge.org/blog/perl-weekly-challenge-257/
/*#

Task 1: Smaller than Current

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a array of integers, @ints.

   Write a script to find out how many integers are smaller than current
   i.e. foreach ints[i], count ints[j] < ints[i] where i != j.

Example 1

Input: @ints = (5, 2, 1, 6)
Output: (2, 1, 0, 3)

For $ints[0] = 5, there are two integers (2,1) smaller than 5.
For $ints[1] = 2, there is one integer (1) smaller than 2.
For $ints[2] = 1, there is none integer smaller than 1.
For $ints[3] = 6, there are three integers (5,2,1) smaller than 6.

Example 2

Input: @ints = (1, 2, 0, 3)
Output: (1, 2, 0, 3)

Example 3

Input: @ints = (0, 1)
Output: (0, 1)

Example 4

Input: @ints = (9, 4, 9, 2)
Output: (2, 1, 2, 0)

Task 2: Reduced Row Echelon
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) countSmaller() ints {
	s := make(ints, len(is))
	for i, v := range is {
		for _, e := range is {
			if e < v {
				s[i]++
			}
		}
	}
	return s
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{5, 2, 1, 6}, ints{2, 1, 0, 3}},
		{ints{1, 2, 0, 3}, ints{1, 2, 0, 3}},
		{ints{0, 1}, ints{0, 1}},
		{ints{9, 4, 9, 2}, ints{2, 1, 2, 0}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.countSmaller(), data.output)) // blank if ok, otherwise show the differences
	}
}
