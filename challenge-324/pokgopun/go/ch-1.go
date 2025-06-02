//# https://theweeklychallenge.org/blog/perl-weekly-challenge-324/
/*#

Task 1: 2D Array

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers and two integers $r amd $c.

   Write a script to create two dimension array having $r rows and $c
   columns using the given array.

Example 1

Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
Output: ([1, 2], [3, 4])

Example 2

Input: @ints = (1, 2, 3), $r = 1, $c = 3
Output: ([1, 2, 3])

Example 3

Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
Output: ([1], [2], [3], [4])

Task 2: Total XOR
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
	ints ints
	r, c int
}

func (in input) process() []ints {
	var r []ints
	for i := range in.r {
		r = append(r, in.ints[i*in.c:i*in.c+in.c])
	}
	return r
}

func main() {
	for _, data := range []struct {
		input  input
		output []ints
	}{
		{input{ints{1, 2, 3, 4}, 2, 2}, []ints{ints{1, 2}, ints{3, 4}}},
		{input{ints{1, 2, 3}, 1, 3}, []ints{ints{1, 2, 3}}},
		{input{ints{1, 2, 3, 4}, 4, 1}, []ints{ints{1}, ints{2}, ints{3}, ints{4}}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
