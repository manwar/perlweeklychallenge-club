//# https://theweeklychallenge.org/blog/perl-weekly-challenge-345/
/*#

Task 1: Peak Positions

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Find all the peaks in the array, a peak is an element that is strictly
   greater than its left and right neighbours. Return the indices of all
   such peak positions.

Example 1

Input: @ints = (1, 3, 2)
Output: (1)

Example 2

Input: @ints = (2, 4, 6, 5, 3)
Output: (2)

Example 3

Input: @ints = (1, 2, 3, 2, 4, 1)
Output: (2, 4)

Example 4

Input: @ints = (5, 3, 1)
Output: (0)

Example 5

Input: @ints = (1, 5, 1, 5, 1, 5, 1)
Output: (1, 3, 5)

Task 2: Last Visitor
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (in ints) process() ints {
	l := len(in)
	if l == 0 {
		return ints{}
	} else if l == 1 {
		return ints{0}
	}
	i := 0
	var p ints
	for i < l {
		if i == l-1 {
			p = append(p, i)
			break
		}
		if in[i] < in[i+1] {
			i++
			continue
		}
		if in[i] > in[i+1] {
			p = append(p, i)
		}
		i += 2
		if i == l-1 && in[i] <= in[i-1] {
			break
		}
	}
	return p
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{1, 3, 2}, ints{1}},
		{ints{2, 4, 6, 5, 3}, ints{2}},
		{ints{1, 2, 3, 2, 4, 1}, ints{2, 4}},
		{ints{5, 3, 1}, ints{0}},
		{ints{1, 5, 1, 5, 1, 5, 1}, ints{1, 3, 5}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
