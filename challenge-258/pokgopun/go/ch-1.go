//# https://theweeklychallenge.org/blog/perl-weekly-challenge-258/
/*#

Task 1: Count Even Digits Number

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a array of positive integers, @ints.

   Write a script to find out how many integers have even number of
   digits.

Example 1

Input: @ints = (10, 1, 111, 24, 1000)
Output: 3

There are 3 integers having even digits i.e. 10, 24 and 1000.

Example 2

Input: @ints = (111, 1, 11111)
Output: 0

Example 3

Input: @ints = (2, 8, 1024, 256)
Output: 1

Task 2: Sum of Values
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type num int

func (nm num) countDigit() int {
	c := 0
	for nm > 0 {
		nm /= 10
		c++
	}
	return c
}

type nums []num

func (ns nums) cedn() int {
	c := 0
	for _, v := range ns {
		if v.countDigit()%2 == 0 {
			c++
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  nums
		output int
	}{
		{nums{10, 1, 111, 24, 1000}, 3},
		{nums{111, 1, 11111}, 0},
		{nums{2, 8, 1024, 256}, 1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.cedn(), data.output)) // blank if ok, otherwise show the differences
	}
}
