//# https://theweeklychallenge.org/blog/perl-weekly-challenge-336/
/*#

Task 1: Equal Group

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return true if the given array can be divided into
   one or more groups: each group must be of the same size as the others,
   with at least two members, and with all members having the same value.

Example 1

Input: @ints = (1,1,2,2,2,2)
Output: true

Groups: (1,1), (2,2), (2,2)

Example 2

Input: @ints = (1,1,1,2,2,2,3,3)
Output: false

Groups: (1,1,1), (2,2,2), (3,3)

Example 3

Input: @ints = (5,5,5,5,5,5,7,7,7,7,7,7)
Output: true

Groups: (5,5,5,5,5,5), (7,7,7,7,7,7)

Example 4

Input: @ints = (1,2,3,4)
Output: false

Example 5

Input: @ints = (8,8,9,9,10,10,11,11)
Output: true

Groups: (8,8), (9,9), (10,10), (11,11)

Task 2: Final Score
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

func (in ints) process() bool {
	slices.Sort(in)
	l := len(in)
	if l < 2 {
		return false
	}
	var res bool
	for d := 2; d <= l; d++ {
		if l%d != 0 {
			continue
		}
		res = true
		for i := d; i <= l; i += d {
			n := in[i-d]
			for _, v := range in[i-d+1 : i] {
				if v != n {
					res = false
					goto skip
				}
			}
		}
	skip:
		if res == true {
			break
		}
	}
	return res
}

func main() {
	for _, data := range []struct {
		input  ints
		output bool
	}{
		{ints{1, 1, 2, 2, 2, 2}, true},
		{ints{1, 1, 1, 2, 2, 2, 3, 3}, false},
		{ints{5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7}, true},
		{ints{1, 2, 3, 4}, false},
		{ints{8, 8, 9, 9, 10, 10, 11, 11}, true},
		{ints{1, 1}, true},
		{ints{1, 1, 1, 2, 2, 2, 3, 3, 3}, true},
		{ints{1, 1, 1, 1, 1, 1, 3, 3, 3}, true},
		{ints{1, 1, 1, 3, 3, 3, 3, 3, 3}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
