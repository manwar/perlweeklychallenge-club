//# https://theweeklychallenge.org/blog/perl-weekly-challenge-333/
/*#

Task 2: Duplicate Zeros

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to duplicate each occurrence of zero, shifting the
   remaining elements to the right. The elements beyond the length of the
   original array are not written.

Example 1

Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
Output: (1, 0, 0, 2, 3, 0, 0, 4)

Each zero is duplicated.
Elements beyond the original length (like 5 and last 0) are discarded.

Example 2

Input: @ints = (1, 2, 3)
Output: (1, 2, 3)

No zeros exist, so the array remains unchanged.

Example 3

Input: @ints = (1, 2, 3, 0)
Output: (1, 2, 3, 0)

Example 4

Input: @ints = (0, 0, 1, 2)
Output: (0, 0, 0, 0)

Example 5

Input: @ints = (1, 2, 0, 3, 4)
Output: (1, 2, 0, 0, 3)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 10th August
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"github.com/google/go-cmp/cmp"
	"io"
	"os"
	"slices"
)

type ints []int

func (in ints) dz() ints {
	l := len(in) - 1
	i := 0
	for i < l {
		if in[i] == 0 {
			in = slices.Insert(in, i, 0)
			i++
		}
		i++
	}
	return in[:l+1]
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{1, 0, 2, 3, 0, 4, 5, 0}, ints{1, 0, 0, 2, 3, 0, 0, 4}},
		{ints{1, 2, 3}, ints{1, 2, 3}},
		{ints{1, 2, 3, 0}, ints{1, 2, 3, 0}},
		{ints{0, 0, 1, 2}, ints{0, 0, 0, 0}},
		{ints{1, 2, 0, 3, 4}, ints{1, 2, 0, 0, 3}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.dz(), data.output)) // blank if ok, otherwise show the differeice

	}
}
