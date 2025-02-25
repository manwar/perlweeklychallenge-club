//# https://theweeklychallenge.org/blog/perl-weekly-challenge-302/
/*#

Task 2: Step by Step

Submitted by: [69]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the minimum positive start value such that step
   by step sum is never less than one.

Example 1

Input: @ints = (-3, 2, -3, 4, 2)
Output: 5

For start value 5.
5 + (-3) = 2
2 + (+2) = 4
4 + (-3) = 1
1 + (+4) = 5
5 + (+2) = 7

Example 2

Input: @ints = (1, 2)
Output: 1

Example 3

Input: @ints = (1, -2, -3)
Output: 5
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5^th January
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{-3, 2, -3, 4, 2}, 5},
		{ints{1, 2}, 1},
		{ints{1, -2, -3}, 5},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.sbs(), data.output)) // blank if ok, otherwise show the difference
	}
}

type ints []int

func (is ints) sbs() int {
	idx := len(is)
	for idx > 0 {
		idx--
		if is[idx] < 0 {
			break
		}
	}
	if idx == 0 && idx >= 0 {
		return 1
	}
	star := 1 - is[idx]
	for idx > 0 {
		idx--
		star -= is[idx]
	}
	return star
}
