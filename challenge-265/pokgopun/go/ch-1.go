//# https://theweeklychallenge.org/blog/perl-weekly-challenge-265/
/*#

Task 1: 33% Appearance

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find an integer in the given array that appeared 33%
   or more. If more than one found, return the smallest. If none found
   then return undef.

Example 1

Input: @ints = (1,2,3,3,3,3,4,2)
Output: 3

1 appeared 1 times.
2 appeared 2 times.
3 appeared 4 times.

3 appeared 50% (>33%) in the given array.

Example 2

Input: @ints = (1,1)
Output: 1

1 appeared 2 times.

1 appeared 100% (>33%) in the given array.

Example 3

Input: @ints = (1,2,3)
Output: 1

1 appeared 1 times.
2 appeared 1 times.
3 appeared 1 times.

Since all three appeared 33.3% (>33%) in the given array.
We pick the smallest of all.

Task 2: Completing Word
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

type Inta struct {
	Val int
	Nul bool
}

func (is ints) ota() Inta {
	l := len(is)
	m := make(map[int]int)
	for _, v := range is {
		m[v]++
	}
	slices.Sort(is)
	var i, j int = l - 1, l
	for i > 0 {
		if is[i] == is[i-1] {
			copy(is[i-1:], is[i:])
			j--
		}
		i--
	}
	for _, v := range is[:j] {
		if float64(m[v])/float64(l) >= 0.33 {
			return Inta{Val: v}
		}
	}
	return Inta{Nul: true}
}

func main() {
	for _, data := range []struct {
		input  ints
		output Inta
	}{
		{ints{1, 2, 3, 3, 3, 3, 4, 2}, Inta{Val: 3}},
		{ints{1, 1}, Inta{Val: 1}},
		{ints{1, 2, 3}, Inta{Val: 1}},
		{ints{1, 2, 3, 4}, Inta{Nul: true}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.ota(), data.output)) // blank if ok, otherwise show the difference
	}
}
