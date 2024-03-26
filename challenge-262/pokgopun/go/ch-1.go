//# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/
/*#

Task 1: Max Positive Negative

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return the maximum number of either positive or
   negative integers in the given array.

Example 1

Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
Output: 4

Count of positive integers: 4
Count of negative integers: 3
Maximum of count of positive and negative integers: 4

Example 2

Input: @ints = (-1, -2, -3, 1)
Output: 3

Count of positive integers: 1
Count of negative integers: 3
Maximum of count of positive and negative integers: 3

Example 3

Input: @ints = (1,2)
Output: 2

Count of positive integers: 2
Count of negative integers: 0
Maximum of count of positive and negative integers: 2

Task 2: Count Equal Divisible
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) max() int {
	c := 0
	for _, v := range is {
		if v < 0 {
			c++
		}
	}
	return max(len(is)-c, c)
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{-3, 1, 2, -1, 3, -2, 4}, 4},
		{ints{-1, -2, -3, 1}, 3},
		{ints{1, 2}, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.max(), data.output)) // blank if ok, otherwise show the difference
	}
}
