//# https://theweeklychallenge.org/blog/perl-weekly-challenge-318/
/*#

Task 2: Reverse Equals

Submitted by: [43]Roger Bell_West
     __________________________________________________________________

   You are given two arrays of integers, each containing the same elements
   as the other.

   Write a script to return true if one array can be made to equal the
   other by reversing exactly one contiguous subarray.

Example 1

Input: @source = (3, 2, 1, 4)
       @target = (1, 2, 3, 4)
Output: true

Reverse elements: 0-2

Example 2

Input: @source = (1, 3, 4)
       @target = (4, 1, 3)
Output: false

Example 3

Input: @source = (2)
       @target = (2)
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 27th April
   2025.
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
	src, dst ints
}

type pairOfInt struct {
	a, b int
}

func (in input) process() bool {
	var poip [2]pairOfInt
	count := len(poip)
	for i := range len(in.src) {
		a, b := in.src[i], in.dst[i]
		if a != b {
			if count == 0 {
				return false
			}
			count--
			poip[count] = pairOfInt{a, b}
		}
	}
	return count == 2 || (count == 0 && poip[0].a == poip[1].b && poip[0].b == poip[1].a)
}

func main() {
	for _, data := range []struct {
		input  input
		output bool
	}{
		{input{ints{3, 2, 1, 4}, ints{1, 2, 3, 4}}, true},
		{input{ints{1, 3, 4}, ints{4, 1, 3}}, false},
		{input{ints{2}, ints{2}}, true},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
