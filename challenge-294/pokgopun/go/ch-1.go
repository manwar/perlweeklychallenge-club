//# https://theweeklychallenge.org/blog/perl-weekly-challenge-294/
/*#

Task 1: Consecutive Sequence

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an unsorted array of integers, @ints.

   Write a script to return the length of the longest consecutive elements
   sequence. Return -1 if none found. The algorithm must runs in O(n)
   time.

Example 1

Input: @ints = (10, 4, 20, 1, 3, 2)
Output: 4

The longest consecutive sequence (1, 2, 3, 4).
The length of the sequence is 4.

Example 2

Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
Output: 9

Example 3

Input: @ints = (10, 30, 20)
Output: -1

Task 2: Next Permutation
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

func (is ints) lcs() int {
	if len(is) < 2 {
		return -1
	}
	slices.Sort(is)
	count := 0
	mx := 0
	p := is[0]
	for _, v := range is[1:] {
		if p == v-1 {
			count++
			if count > mx {
				mx = count
			}
		} else {
			count = 0
		}
		p = v
	}
	if mx == 0 {
		return -1
	}
	return mx + 1
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{10, 4, 20, 1, 3, 2}, 4},
		{ints{0, 6, 1, 8, 5, 2, 4, 3, 0, 7}, 9},
		{ints{10, 30, 20}, -1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.lcs(), data.output)) // blank if ok, otherwise show the difference
	}
}
