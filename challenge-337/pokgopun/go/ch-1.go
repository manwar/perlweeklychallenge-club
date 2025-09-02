//# https://theweeklychallenge.org/blog/perl-weekly-challenge-337/
/*#

Task 1: Smaller Than Current

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of numbers, @num1.

   Write a script to return an array, @num2, where $num2[i] is the count
   of all numbers less than or equal to $num1[i].

Example 1

Input: @num1 = (6, 5, 4, 8)
Output: (2, 1, 0, 3)

index 0: numbers <= 6 are 5, 4    => 2
index 1: numbers <= 5 are 4       => 1
index 2: numbers <= 4, none       => 0
index 3: numbers <= 8 are 6, 5, 4 => 3

Example 2

Input: @num1 = (7, 7, 7, 7)
Output: (3, 3, 3, 3)

Example 3

Input: @num1 = (5, 4, 3, 2, 1)
Output: (4, 3, 2, 1, 0)

Example 4

Input: @num1 = (-1, 0, 3, -2, 1)
Output: (1, 2, 4, 0, 3)

Example 5

Input: @num1 = (0, 1, 1, 2, 0)
Output: (1, 3, 3, 4, 1)

Task 2: Odd Matrix
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
	l := len(in)
	s := make(ints, l)
	for i, v := range in {
		j := l
		for j > 0 {
			j--
			if j != i && in[j] <= v {
				s[i]++
			}
		}
	}
	return s
}

func main() {
	for _, data := range []struct {
		input, output ints
	}{
		{ints{6, 5, 4, 8}, ints{2, 1, 0, 3}},
		{ints{7, 7, 7, 7}, ints{3, 3, 3, 3}},
		{ints{5, 4, 3, 2, 1}, ints{4, 3, 2, 1, 0}},
		{ints{-1, 0, 3, -2, 1}, ints{1, 2, 4, 0, 3}},
		{ints{0, 1, 1, 2, 0}, ints{1, 3, 3, 4, 1}},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
