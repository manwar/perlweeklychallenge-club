//# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/
/*#

Task 2: Sum of Values

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @int and an integer $k.

   Write a script to find the sum of values whose index binary
   representation has exactly $k number of 1-bit set.

Example 1

Input: @ints = (2, 5, 9, 11, 3), $k = 1
Output: 17

Binary representation of index 0 = 0
Binary representation of index 1 = 1
Binary representation of index 2 = 10
Binary representation of index 3 = 11
Binary representation of index 4 = 100

So the indices 1, 2 and 4 have total one 1-bit sets.
Therefore the sum, $ints[1] + $ints[2] + $ints[3] = 17

Example 2

Input: @ints = (2, 5, 9, 11, 3), $k = 2
Output: 11

Example 3

Input: @ints = (2, 5, 9, 11, 3), $k = 0
Output: 2
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 1st March 2024.
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

type num int

func (nm num) countOn() int {
	c := 0
	for nm > 0 {
		if nm%2 == 1 {
			c++
		}
		nm /= 2
	}
	return c
}

type nums []int

func (ns nums) sov(n int) int {
	s := 0
	for i, v := range ns {
		if num(i).countOn() == n {
			s += v
		}
	}
	return s
}

func main() {
	for _, data := range []struct {
		ints   nums
		k      int
		output int
	}{
		{nums{2, 5, 9, 11, 3}, 1, 17},
		{nums{2, 5, 9, 11, 3}, 2, 11},
		{nums{2, 5, 9, 11, 3}, 0, 2},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.ints.sov(data.k), data.output)) // blank if ok, otherwise show the differences
	}
}
