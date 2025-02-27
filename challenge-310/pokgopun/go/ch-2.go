//# https://theweeklychallenge.org/blog/perl-weekly-challenge-310/
/*#

Task 2: Sort Odd Even

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to sort odd index elements in decreasing order and even
   index elements in increasing order in the given array.

Example 1

Input: @ints = (4, 1, 2, 3)
Output: (2, 3, 4, 1)

Even index elements: 4, 2 => 2, 4 (increasing order)
Odd index elements : 1, 3 => 3, 1 (decreasing order)

Example 2

Input: @ints = (3, 1)
Output: (3, 1)

Example 3

Input: @ints = (5, 3, 2, 1, 4)
Output: (2, 3, 4, 1, 5)

Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
Odd index elements : 3, 1 => 3, 1 (decreasing order)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 2^nd March
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"slices"
	"sort"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) soe() ints {
	l := len(is)
	s := make(ints, l)
	if l <= 2 {
		copy(s, is)
		return s
	}
	ol := l / 2
	o := ints{}
	for i := range ol {
		o = append(o, is[i*2+1])
	}
	sort.Slice(o, func(i, j int) bool {
		return o[i] > o[j]
	})
	for i := range ol {
		s[i*2+1] = o[i]
	}
	el := l/2 + l%2
	e := ints{}
	for i := range el {
		e = append(e, is[i*2])
	}
	slices.Sort(e)
	for i := range el {
		s[i*2] = e[i]
	}
	return s
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{4, 1, 2, 3}, ints{2, 3, 4, 1}},
		{ints{3, 1}, ints{3, 1}},
		{ints{5, 3, 2, 1, 4}, ints{2, 3, 4, 1, 5}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.soe(), data.output)) // blank if ok, otherwise show the difference
	}
}
