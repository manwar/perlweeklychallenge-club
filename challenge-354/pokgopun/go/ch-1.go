//# https://theweeklychallenge.org/blog/perl-weekly-challenge-354/
/*#

Task 1: Min Abs Diff

Submitted by: [72]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of distinct integers.

   Write a script to find all pairs of elements with the minimum absolute
   difference.
Rules (a,b):
1: a, b are from the given array.
2: a < b
3: b - a = min abs diff any two elements in the given array

Example 1

Input: @ints= (4, 2, 1, 3)
Output: [1, 2], [2, 3], [3, 4]

Example 2

Input: @ints = (10, 100, 20, 30)
Output: [10, 20], [20, 30]

Example 3

Input: @ints = (-5, -2, 0, 3)
Output: [-2, 0]

Example 4

Input: @ints = (8, 1, 15, 3)
Output: [1, 3]

Example 5

Input: @ints = (12, 5, 9, 1, 15)
Output: [9, 12], [12, 15]

Task 2: Shift Grid
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type pair struct {
	A, B int
}

type pairs []pair

type ints []int

func (in ints) process() pairs {
	slices.Sort(in)
	l := len(in)
	mn := in[l-1] - in[0]
	var ps pairs
	l--
	for i := 0; i < l; i++ {
		p := pair{in[i], in[i+1]}
		d := p.B - p.A
		if mn == d {
			ps = append(ps, p)
		} else if mn > d {
			mn = d
			ps = pairs{p}
		}
	}
	return ps
}

func main() {
	for _, data := range []struct {
		input  ints
		output pairs
	}{
		{ints{4, 2, 1, 3}, pairs{pair{1, 2}, pair{2, 3}, pair{3, 4}}},
		{ints{10, 100, 20, 30}, pairs{pair{10, 20}, pair{20, 30}}},
		{ints{-5, -2, 0, 3}, pairs{pair{-2, 0}}},
		{ints{8, 1, 15, 3}, pairs{pair{1, 3}}},
		{ints{12, 5, 9, 1, 15}, pairs{pair{9, 12}, pair{12, 15}}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
