//# https://theweeklychallenge.org/blog/perl-weekly-challenge-338/
/*#

Task 1: Highest Row

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a m x n matrix.

   Write a script to find the highest row sum in the given matrix.

Example 1

Input: @matrix = ([4,  4, 4, 4],
                  [10, 0, 0, 0],
                  [2,  2, 2, 9])
Output: 16

Row 1: 4  + 4 + 4 + 4 => 16
Row 2: 10 + 0 + 0 + 0 => 10
Row 3: 2  + 2 + 2 + 9 => 15

Example 2

Input: @matrix = ([1, 5],
                  [7, 3],
                  [3, 5])
Output: 10

Example 3

Input: @matrix = ([1, 2, 3],
                  [3, 2, 1])
Output: 6

Example 4

Input: @matrix = ([2, 8, 7],
                  [7, 1, 3],
                  [1, 9, 5])
Output: 17

Example 5

Input: @matrix = ([10, 20,  30],
                  [5,  5,   5],
                  [0,  100, 0],
                  [25, 25,  25])
Output: 100

Task 2: Max Distance
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (in ints) sum() int {
	s := 0
	for _, v := range in {
		s += v
	}
	return s
}

type input []ints

func (in input) process() int {
	s := in[0].sum()
	for _, v := range in[1:] {
		s = max(s, v.sum())
	}
	return s
}

func main() {
	for _, data := range []struct {
		input  input
		output int
	}{
		{input{ints{4, 4, 4, 4},
			ints{10, 0, 0, 0},
			ints{2, 2, 2, 9}}, 16},
		{input{ints{1, 5},
			ints{7, 3},
			ints{3, 5}}, 10},
		{input{ints{1, 2, 3},
			ints{3, 2, 1}}, 6},
		{input{ints{2, 8, 7},
			ints{7, 1, 3},
			ints{1, 9, 5}}, 17},
		{input{ints{10, 20, 30},
			ints{5, 5, 5},
			ints{0, 100, 0},
			ints{25, 25, 25}}, 100},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
