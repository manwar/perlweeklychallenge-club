//# https://theweeklychallenge.org/blog/perl-weekly-challenge-320/
/*#

Task 2: Sum Difference

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of positive integers.

   Write a script to return the absolute difference between digit sum and
   element sum of the given array.

Example 1

Input: @ints = (1, 23, 4, 5)
Output: 18

Element sum: 1 + 23 + 4 + 5 => 33
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 33 - 15 | => 18

Example 2

Input: @ints = (1, 2, 3, 4, 5)
Output: 0

Element sum: 1 + 2 + 3 + 4 + 5 => 15
Digit sum: 1 + 2 + 3 + 4 + 5 => 15
Absolute difference: | 15 - 15 | => 0

Example 3

Input: @ints = (1, 2, 34)
Output: 27

Element sum: 1 + 2 + 34 => 37
Digit sum: 1 + 2 + 3 + 4 => 10
Absolute difference: | 37 - 10 | => 27
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 11th May 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"
	"strconv"

	"github.com/google/go-cmp/cmp"
)

type input []int

func (in input) process() int {
	sm := in.sum()
	smd := in.sumDigit()
	if sm > smd {
		return sm - smd
	}
	return smd - sm
}

func (in input) sum() int {
	sm := 0
	for _, v := range in {
		sm += v
	}
	return sm
}

func (in input) sumDigit() int {
	sm := 0
	for _, v := range in {
		for _, r := range strconv.Itoa(v) {
			sm += int(r - '0')
		}
	}
	return sm
}

func main() {
	for _, data := range []struct {
		input  input
		output int
	}{
		{input{1, 23, 4, 5}, 18},
		{input{1, 2, 3, 4, 5}, 0},
		{input{1, 2, 34}, 27},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
