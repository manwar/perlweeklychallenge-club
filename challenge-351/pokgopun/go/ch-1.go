//# https://theweeklychallenge.org/blog/perl-weekly-challenge-351/
/*#

Task 1: Special Average

Submitted by: [55]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return the average excluding the minimum and maximum
   of the given array.

Example 1

Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
Output: 5250

Min: 2000
Max: 8000
Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250

Example 2

Input: @ints = (100_000, 80_000, 110_000, 90_000)
Output: 95_000

Min: 80_000
Max: 110_000
Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000

Example 3

Input: @ints = (2500, 2500, 2500, 2500)
Output: 0

Min: 2500
Max: 2500
Avg: 0

Example 4

Input: @ints = (2000)
Output: 0

Min: 2000
Max: 2000
Avg: 0

Example 5

Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
Output: 3500

Min: 1000
Max: 6000
Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500

Task 2: Arithmetic Progression
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

func (in ints) process() int {
	i := len(in) - 1
	if i < 2 {
		return 0
	}
	slices.Sort(in)
	mn, mx := in[0], in[i]
	var s, n int
	for i > 1 {
		i--
		v := in[i]
		if mn < v && v < mx {
			s += v
			n++
		}
	}
	if s > 0 {
		return s / n
	}
	return 0
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{8000, 5000, 6000, 2000, 3000, 7000}, 5250},
		{ints{100_000, 80_000, 110_000, 90_000}, 95_000},
		{ints{2500, 2500, 2500, 2500}, 0},
		{ints{2000}, 0},
		{ints{1000, 2000, 3000, 4000, 5000, 6000}, 3500},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
