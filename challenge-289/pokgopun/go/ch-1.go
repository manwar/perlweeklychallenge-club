//# https://theweeklychallenge.org/blog/perl-weekly-challenge-289/
/*#

Task 1: Third Maximum

Submitted by: [50]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the third distinct maximum in the given array.
   If third maximum doesn’t exist then return the maximum number.

Example 1

Input: @ints = (5, 6, 4, 1)
Output: 4

The first distinct maximum is 6.
The second distinct maximum is 5.
The third distinct maximum is 4.

Example 2

Input: @ints = (4, 5)
Output: 5

In the given array, the third maximum doesn't exist therefore returns the maximu
m.

Example 3

Input: @ints =  (1, 2, 2, 3)
Output: 1

The first distinct maximum is 3.
The second distinct maximum is 2.
The third distinct maximum is 1.

Task 2: Jumbled Letters
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

func (is ints) thirdMax() int {
	slices.Sort(is)
	is = slices.Compact(is)
	//fmt.Println(is)
	l := len(is)
	if l > 2 {
		return is[l-3]
	}
	return is[l-1]
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{5, 6, 4, 1}, 4},
		{ints{4, 5}, 5},
		{ints{1, 2, 2, 3}, 1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.thirdMax(), data.output)) // blank if ok, otherwise show the differences
	}
}
