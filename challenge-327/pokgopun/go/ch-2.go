//# https://theweeklychallenge.org/blog/perl-weekly-challenge-327/
/*#

Task 2: MAD

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of distinct integers.

   Write a script to find all pairs of elements with minimum absolute
   difference (MAD) of any two elements.

Example 1

Input: @ints = (4, 1, 2, 3)
Output: [1,2], [2,3], [3,4]

The minimum absolute difference is 1.
Pairs with MAD: [1,2], [2,3], [3,4]

Example 2

Input: @ints = (1, 3, 7, 11, 15)
Output: [1,3]

Example 3

Input: @ints = (1, 5, 3, 8)
Output: [1,3], [3,5]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 29th June 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
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

type intss []ints

func (in ints) process() intss {
	s := slices.Clone(in)
	slices.Sort(s)
	l := len(s)
	if l < 2 {
		return intss{}
	}
	mn := s[1] - s[0]
	i := l
	for i > 2 {
		i--
		m := s[i] - s[i-1]
		if mn > m {
			mn = m
		}
	}
	var r intss
	for i := range l - 1 {
		j := i + 1
		for j < l {
			if s[j]-s[i] == mn {
				r = append(r, ints{s[i], s[j]})
			}
			j++
		}
	}
	return r
}

func main() {
	for _, data := range []struct {
		input  ints
		output intss
	}{
		{ints{4, 1, 2, 3}, intss{ints{1, 2}, ints{2, 3}, ints{3, 4}}},
		{ints{1, 3, 7, 11, 15}, intss{ints{1, 3}}},
		{ints{1, 5, 3, 8}, intss{ints{1, 3}, ints{3, 5}}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
