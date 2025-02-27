//# https://theweeklychallenge.org/blog/perl-weekly-challenge-310/
/*#

Task 1: Arrays Intersection

Submitted by: [38]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of array of integers.

   Write a script to return the common elements in all the arrays.

Example 1

Input: $list = ( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
Output: (1, 4)

Example 2

Input: $list = ( [1, 0, 2, 3], [2, 4, 5] )
Output: (2)

Example 3

Input: $list = ( [1, 2, 3], [4, 5], [6] )
Output: ()

Task 2: Sort Odd Even
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"maps"
	"os"
	"slices"

	"github.com/google/go-cmp/cmp"
)

type ints []int

type input []ints

func (in input) process() ints {
	m := make(map[int]int)
	for _, is := range in {
		for _, v := range is {
			m[v]++
		}
	}
	otpt := ints{}
	l := len(in)
	ks := slices.Collect(maps.Keys(m))
	for k := range ks {
		if m[k] == l {
			otpt = append(otpt, k)
		}
	}
	return otpt
}

func main() {
	for _, data := range []struct {
		input  input
		output ints
	}{
		{input{ints{1, 2, 3, 4}, ints{4, 5, 6, 1}, ints{4, 2, 1, 3}}, ints{1, 4}},
		{input{ints{1, 0, 2, 3}, ints{2, 4, 5}}, ints{2}},
		{input{ints{1, 2, 3}, ints{4, 5}, ints{6}}, ints{}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
