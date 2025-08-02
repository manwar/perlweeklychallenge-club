//# https://theweeklychallenge.org/blog/perl-weekly-challenge-284/
/*#

Task 1: Lucky Integer

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the lucky integer if found otherwise return -1.
   If there are more than one then return the largest.

     A lucky integer is an integer that has a frequency in the array
     equal to its value.

Example 1

Input: @ints = (2, 2, 3, 4)
Output: 2

Example 2

Input: @ints = (1, 2, 2, 3, 3, 3)
Output: 3

Example 3

Input: @ints = (1, 1, 1, 3)
Output: -1

Task 2: Relative Sort
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) lckI() int {
	m := make(map[int]int)
	for _, v := range is {
		m[v]++
	}
	r := -1
	for k, v := range m {
		if k == v {
			r = max(r, k)
		}
	}
	return r
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{2, 2, 3, 4}, 2},
		{ints{1, 2, 2, 3, 3, 3}, 3},
		{ints{1, 1, 1, 3}, -1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.lckI(), data.output)) // blank if ok, otherwise show the difference
	}
}
