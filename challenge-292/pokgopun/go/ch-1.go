//# https://theweeklychallenge.org/blog/perl-weekly-challenge-292/
/*#

Task 1: Twice Largest

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints, where the largest integer is
   unique.

   Write a script to find whether the largest element in the array is at
   least twice as big as every element in the given array. If it is return
   the index of the largest element or return -1 otherwise.

Example 1

Input: @ints = (2, 4, 1, 0)
Output: 1

The largest integer is 4.
For every other elements in the given array is at least twice as big.
The index value of 4 is 1.

Example 2

Input: @ints = (1, 2, 3, 4)
Output: -1

The largest integer is 4.
4 is less than twice the value of 3, so we return -1.

Task 2: Zuma Game
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) tl() int {
	l := len(is)
	if l > 2 {
		i0, i1 := l-1, l-2
		if is[i0] < is[i1] {
			i0, i1 = i1, i0
		}
		for i := range l - 2 {
			if is[i] > is[i0] {
				i1, i0 = i0, i
			} else if is[i] > is[i1] {
				i1 = i
			}
		}
		if is[i0] >= 2*is[i1] {
			return i0
		}
	}
	return -1
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{2, 4, 1, 0}, 1},
		{ints{1, 2, 3, 4}, -1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.tl(), data.output)) // blank if ok, otherwise show the difference
	}
}
