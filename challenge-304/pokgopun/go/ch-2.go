//# https://theweeklychallenge.org/blog/perl-weekly-challenge-304/
/*#

Task 2: Maximum Average

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints and an integer, $n which is
   less than or equal to total elements in the given array.

   Write a script to find the contiguous subarray whose length is the
   given integer, $n, and has the maximum average. It should return the
   average.

Example 1

Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
Output: 12.75

Subarray: (12, -5, -6, 50)
Average: (12 - 5 - 6 + 50) / 4 = 12.75

Example 2

Input: @ints = (5), $n = 1
Output: 5
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 19^th January
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

type ints []int

func (is ints) sum() int {
	sm := 0
	for _, v := range is {
		sm += v
	}
	return sm
}

type input struct {
	ints ints
	n    int
}

func (in input) process() float32 {
	ints, n := in.ints, in.n
	sm := ints[:n].sum()
	mx := sm
	for i := range len(ints) - n {
		sm += ints[i+n] - ints[i]
		if sm > mx {
			mx = sm
		}
	}
	return float32(mx*100/n) / 100
}

func main() {
	for _, data := range []struct {
		input  input
		output float32
	}{
		{input{ints{1, 12, -5, -6, 50, 3}, 4}, 12.75},
		{input{ints{5}, 1}, 5},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
