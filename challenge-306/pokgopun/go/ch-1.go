//# https://theweeklychallenge.org/blog/perl-weekly-challenge-306/
/*#

Task 1: Odd Sum

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of positive integers, @ints.

   Write a script to return the sum of all possible odd-length subarrays
   of the given array. A subarray is a contiguous subsequence of the
   array.

Example 1

Input: @ints = (2, 5, 3, 6, 4)
Output: 77

Odd length sub-arrays:
(2) => 2
(5) => 5
(3) => 3
(6) => 6
(4) => 4
(2, 5, 3) => 10
(5, 3, 6) => 14
(3, 6, 4) => 13
(2, 5, 3, 6, 4) => 20

Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77

Example 2

Input: @ints = (1, 3)
Output: 4

Task 2: Last Element
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) odsm() int {
	sm := 0
	l := len(is)
	o := 1
	for o <= l {
		i := 0
		for i+o <= l {
			for _, v := range is[i : i+o] {
				sm += v
			}
			i++
		}
		o += 2
	}
	return sm
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{2, 5, 3, 6, 4}, 77},
		{ints{1, 3}, 4},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.odsm(), data.output)) // blank if ok, otherwise show the difference
	}
}
