//# https://theweeklychallenge.org/blog/perl-weekly-challenge-304/
/*#

Task 1: Arrange Binary

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of binary digits (0 and 1) and a positive integer,
   $n.

   Write a script to return true if you can re-arrange the list by
   replacing at least $n digits with 1 in the given list so that no two
   consecutive digits are 1 otherwise return false.

Example 1

Input: @digits = (1, 0, 0, 0, 1), $n = 1
Output: true

Re-arranged list: (1, 0, 1, 0, 1)

Example 2

Input: @digits = (1, 0, 0, 0, 1), $n = 2
Output: false

Task 2: Maximum Average
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
	n    int
}

func (in input) process() bool {
	is, n := in.ints, in.n
	l := len(is) - 1
	i := 0
	for i < l {
		if is[i] == 1 {
			if is[i+1] == 1 {
				return false
			}
			i += 2
			continue
		}
		if is[i+1] == 0 {
			n--
			i += 2
			continue
		}
		i++
	}
	if i == l && is[i] == 0 {
		n--
	}
	return n <= 0
}

func main() {
	for _, data := range []struct {
		input  input
		output bool
	}{
		{input{ints{1, 0, 0, 0, 1}, 1}, true},
		{input{ints{1, 0, 0, 0, 1}, 2}, false},
		{input{ints{1, 1, 0, 0, 0, 1}, 1}, false},
		{input{ints{1, 0, 0, 0, 1, 1}, 1}, false},
		{input{ints{1, 0, 0}, 1}, true},
		{input{ints{0, 0, 1}, 1}, true},
		{input{ints{1, 0, 0, 0, 0, 1}, 2}, false},
		{input{ints{1, 0, 0, 0, 0, 0, 1}, 2}, true},
		{input{ints{0, 0, 0, 0, 0}, 3}, true},
		{input{ints{0, 0, 0, 0, 0}, 4}, false},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
