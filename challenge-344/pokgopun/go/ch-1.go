//# https://theweeklychallenge.org/blog/perl-weekly-challenge-344/
/*#

Task 1: Array Form Compute

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints and an integer, $x.

   Write a script to add $x to the integer in the array-form.

     The array form of an integer is a digit-by-digit representation
     stored as an array, where the most significant digit is at the 0th
     index.

Example 1

Input: @ints = (1, 2, 3, 4), $x = 12
Output: (1, 2, 4, 6)

Example 2

Input: @ints = (2, 7, 4), $x = 181
Output: (4, 5, 5)

Example 3

Input: @ints = (9, 9, 9), $x = 1
Output: (1, 0, 0, 0)

Example 4

Input: @ints = (1, 0, 0, 0, 0), $x = 9999
Output: (1, 9, 9, 9, 9)

Example 5

Input: @ints = (0), $x = 1000
Output: (1, 0, 0, 0)

Task 2: Array Formation
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

func (in ints) int() int {
	l := len(in)
	n := 0
	t := 1
	for l > 0 {
		l--
		n += in[l] * t
		t *= 10
	}
	return n
}

func (in ints) process(n int) ints {
	num := in.int() + n
	var nums ints
	for num > 0 {
		nums = append(nums, num%10)
		num /= 10
	}
	slices.Reverse(nums)
	return nums
}

func main() {
	for _, data := range []struct {
		ints   ints
		int    int
		output ints
	}{
		{ints{1, 2, 3, 4}, 12, ints{1, 2, 4, 6}},
		{ints{2, 7, 4}, 181, ints{4, 5, 5}},
		{ints{9, 9, 9}, 1, ints{1, 0, 0, 0}},
		{ints{1, 0, 0, 0, 0}, 9999, ints{1, 9, 9, 9, 9}},
		{ints{0}, 1000, ints{1, 0, 0, 0}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.ints.process(data.int), data.output)) // blank if ok, otherwise show the difference
	}
}
