//# https://theweeklychallenge.org/blog/perl-weekly-challenge-322/
/*#

Task 2: Rank Array

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return an array of the ranks of each element: the
   lowest value has rank 1, next lowest rank 2, etc. If two elements are
   the same then they share the same rank.

Example 1

Input: @ints = (55, 22, 44, 33)
Output: (4, 1, 3, 2)

Example 2

Input: @ints = (10, 10, 10)
Output: (1, 1, 1)

Example 3

Input: @ints = (5, 1, 1, 4, 3)
Output: (4, 1, 1, 3, 2)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 25th May 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"sort"

	"github.com/google/go-cmp/cmp"
)

type intPair struct {
	a, b int
}

type ints []int

func (in ints) process() ints {
	var ps []intPair
	for i, v := range in {
		ps = append(ps, intPair{v, i})
	}
	sort.Slice(ps, func(i, j int) bool {
		return ps[i].a < ps[j].a
	})
	r := 1
	ps2 := []intPair{intPair{ps[0].b, r}}
	for i := range len(ps) - 1 {
		if ps[i+1].a > ps[i].a {
			r++
		}
		ps2 = append(ps2, intPair{ps[i+1].b, r})
	}
	sort.Slice(ps2, func(i, j int) bool {
		return ps2[i].a < ps2[j].a
	})
	var c ints
	for _, v := range ps2 {
		c = append(c, v.b)
	}
	return c
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{55, 22, 44, 33}, ints{4, 1, 3, 2}},
		{ints{10, 10, 10}, ints{1, 1, 1}},
		{ints{5, 1, 1, 4, 3}, ints{4, 1, 1, 3, 2}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) //blank if ok, otherwise show the difference
	}
}
