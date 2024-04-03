//# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/
/*#

Task 1: Target Index

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints and a target element $k.

   Write a script to return the list of indices in the sorted array where
   the element is same as the given target element.

Example 1

Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
Output: (1, 2)

Sorted array: (1, 2, 2, 3, 4, 5)
Target indices: (1, 2) as $ints[1] = 2 and $ints[2] = 2

Example 2

Input: @ints = (1, 2, 4, 3, 5), $k = 6
Output: ()

No element in the given array matching the given target.

Example 3

Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
Output: (4)

Sorted array: (1, 2, 2, 3, 4, 5)
Target index: (4) as $ints[4] = 4

Task 2: Merge Items
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

func (is ints) targetIndex(n int) ints {
	slices.Sort(is)
	res := ints{}
	for i, v := range is {
		if v == n {
			res = append(res, i)
		}
	}
	return res
}

func main() {
	for _, data := range []struct {
		input  ints
		k      int
		output ints
	}{
		{ints{1, 5, 3, 2, 4, 2}, 2, ints{1, 2}},
		{ints{1, 2, 4, 3, 5}, 6, ints{}},
		{ints{5, 3, 2, 4, 2, 1}, 4, ints{4}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.targetIndex(data.k), data.output)) // blank if ok, otherwise show the difference
	}
}
