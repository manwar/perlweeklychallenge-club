//# https://theweeklychallenge.org/blog/perl-weekly-challenge-319/
/*#

Task 2: Minimum Common

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two arrays of integers.

   Write a script to return the minimum integer common to both arrays. If
   none found return -1.

Example 1

Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (3, 4, 5, 6)
Output: 3

The common integer in both arrays: 3, 4
The minimum is 3.

Example 2

Input: @array_1 = (1, 2, 3)
       @array_2 = (2, 4)
Output: 2

Example 3

Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (5, 6, 7, 8)
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 4th May 2025.
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

type input struct {
	arr1, arr2 ints
}

func (in input) process() int {
	m := make(map[int]int)
	mn := -1
	for _, v := range in.arr1 {
		m[v]++
	}
	for _, v := range in.arr2 {
		if _, ok := m[v]; ok {
			if mn == -1 || mn > v {
				mn = v
			}
		}
	}
	return mn
}

func main() {
	for _, data := range []struct {
		input  input
		output int
	}{
		{input{ints{1, 2, 3, 4}, ints{3, 4, 5, 6}}, 3},
		{input{ints{1, 2, 3}, ints{2, 4}}, 2},
		{input{ints{1, 2, 3, 4}, ints{5, 6, 7, 8}}, -1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
