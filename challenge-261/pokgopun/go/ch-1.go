//# https://theweeklychallenge.org/blog/perl-weekly-challenge-261/
/*#

Task 1: Element Digit Sum

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to evaluate the absolute difference between element and
   digit sum of the given array.

Example 1

Input: @ints = (1,2,3,45)
Output: 36

Element Sum: 1 + 2 + 3 + 45 = 51
Digit Sum: 1 + 2 + 3 + 4 + 5 = 15
Absolute Difference: | 51 - 15 | = 36

Example 2

Input: @ints = (1,12,3)
Output: 9

Element Sum: 1 + 12 + 3 = 16
Digit Sum: 1 + 1 + 2 + 3 = 7
Absolute Difference: | 16 - 7 | = 9

Example 3

Input: @ints = (1,2,3,4)
Output: 0

Element Sum: 1 + 2 + 3 + 4 = 10
Digit Sum: 1 + 2 + 3 + 4 = 10
Absolute Difference: | 10 - 10 | = 0

Example 4

Input: @ints = (236, 416, 336, 350)
Output: 1296

Task 2: Multiply by Two
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

func sumDigit(n int) int {
	if n < 10 {
		return n
	}
	s := 0
	for n > 0 {
		s += n % 10
		n /= 10
	}
	return s
}

type ints []int

func (is ints) sum() int {
	s := 0
	for _, v := range is {
		s += v
	}
	return s
}

func (is ints) sumDigit() int {
	s := 0
	for _, v := range is {
		s += sumDigit(v)
	}
	return s
}

func (is ints) eds() int {
	return is.sum() - is.sumDigit()
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{1, 2, 3, 45}, 36},
		{ints{1, 12, 3}, 9},
		{ints{1, 2, 3, 4}, 0},
		{ints{236, 416, 336, 350}, 1296},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.eds(), data.output)) // blank if ok, otherwise show the difference
	}
}
