//# https://theweeklychallenge.org/blog/perl-weekly-challenge-297/
/*#

Task 2: Semi-Ordered Permutation

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given permutation of $n integers, @ints.

   Write a script to find the minimum number of swaps needed to make the
   @ints a semi-ordered permutation.
A permutation is a sequence of integers from 1 to n of length n containing  each
 number exactly once.
A permutation is called semi-ordered if the first number is 1 and the last numbe
r equals n.

   You are ONLY allowed to pick adjacent elements and swap them.

Example 1

Input: @ints = (2, 1, 4, 3)
Output: 2

Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)

Example 2

Input: @ints = (2, 4, 1, 3)
Output: 3

Swap 4 <=> 1 => (2, 1, 4, 3)
Swap 2 <=> 1 => (1, 2, 4, 3)
Swap 4 <=> 3 => (1, 2, 3, 4)

Example 3

Input: @ints = (1, 3, 2, 4, 5)
Output: 0

Already a semi-ordered permutation.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st December
   2024.
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

type ints []int

func (is ints) sop() int {
	l := len(is)
	mni := slices.Index(is, 1)
	mxi := slices.Index(is, l)
	c := l - 1 - mxi + mni
	if mni > mxi {
		c -= 1
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{2, 1, 4, 3}, 2},
		{ints{2, 4, 1, 3}, 3},
		{ints{1, 3, 2, 4, 5}, 0},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.sop(), data.output)) // blank if ok, otherwise show the difference
	}
}
