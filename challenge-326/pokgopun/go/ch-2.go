//# https://theweeklychallenge.org/blog/perl-weekly-challenge-326/
/*#

Task 2: Decompressed List

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of positive integers having even elements.

   Write a script to to return the decompress list. To decompress, pick
   adjacent pair (i, j) and replace it with j, i times.

Example 1

Input: @ints = (1, 3, 2, 4)
Output: (3, 4, 4)

Pair 1: (1, 3) => 3 one time  => (3)
Pair 2: (2, 4) => 4 two times => (4, 4)

Example 2

Input: @ints = (1, 1, 2, 2)
Output: (1, 2, 2)

Pair 1: (1, 1) => 1 one time  => (1)
Pair 2: (2, 2) => 2 two times => (2, 2)

Example 3

Input: @ints = (3, 1, 3, 2)
Output: (1, 1, 1, 2, 2, 2)

Pair 1: (3, 1) => 1 three times => (1, 1, 1)
Pair 2: (3, 2) => 2 three times => (2, 2, 2)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 22nd June 2025.
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

func (in ints) process() ints {
	var out ints
	for i := range len(in) / 2 {
		j := in[2*i]
		for j > 0 {
			j--
			out = append(out, in[2*i+1])
		}
	}
	return out
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{1, 3, 2, 4}, ints{3, 4, 4}},
		{ints{1, 1, 2, 2}, ints{1, 2, 2}},
		{ints{3, 1, 3, 2}, ints{1, 1, 1, 2, 2, 2}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
