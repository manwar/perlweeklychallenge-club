//# https://theweeklychallenge.org/blog/perl-weekly-challenge-327/
/*#

Task 1: Missing Integers

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of n integers.

   Write a script to find all the missing integers in the range 1..n in
   the given array.

Example 1

Input: @ints = (1, 2, 1, 3, 2, 5)
Output: (4, 6)

The given array has 6 elements.
So we are looking for integers in the range 1..6 in the given array.
The missing integers: (4, 6)

Example 2

Input: @ints = (1, 1, 1)
Output: (2, 3)

Example 3

Input: @ints = (2, 2, 1)
Output: (3)

Task 2: MAD
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
	m := make(map[int]bool)
	for _, v := range in {
		m[v] = true
	}
	var s []int
	for i := range len(in) {
		j := i + 1
		if m[j] {
			continue
		}
		s = append(s, j)
	}
	return s
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{1, 2, 1, 3, 2, 5}, ints{4, 6}},
		{ints{1, 1, 1}, ints{2, 3}},
		{ints{2, 2, 1}, ints{3}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
