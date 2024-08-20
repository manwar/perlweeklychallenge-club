//# https://theweeklychallenge.org/blog/perl-weekly-challenge-283/
/*#

Task 1: Unique Number

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints, where every elements appears
   more than once except one element.

   Write a script to find the one element that appears exactly one time.

Example 1

Input: @ints = (3, 3, 1)
Output: 1

Example 2

Input: @ints = (3, 2, 4, 2, 4)
Output: 3

Example 3

Input: @ints = (1)
Output: 1

Example 4

Input: @ints = (4, 3, 1, 1, 1, 4)
Output: 3

Task 2: Digit Count Value
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) uniqNum() int {
	m := make(map[int]bool)
	for _, v := range is {
		_, ok := m[v]
		if ok {
			m[v] = false
		} else {
			m[v] = true
		}
	}
	for k, v := range m {
		if v {
			return k
		}
	}
	return -1
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{3, 3, 1}, 1},
		{ints{3, 2, 4, 2, 4}, 3},
		{ints{1}, 1},
		{ints{4, 3, 1, 1, 1, 4}, 3},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.uniqNum(), data.output)) // blank if ok, otherwise show the difference
	}
}
