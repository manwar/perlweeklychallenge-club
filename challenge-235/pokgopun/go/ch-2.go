//# https://theweeklychallenge.org/blog/perl-weekly-challenge-235/
/*#

Task 2: Duplicate Zeros

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to duplicate each occurrence of ZERO in the given array
   and shift the remaining to the right but make sure the size of array
   remain the same.

Example 1

Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
Ouput: (1, 0, 0, 2, 3, 0, 0, 4)

Example 2

Input: @ints = (1, 2, 3)
Ouput: (1, 2, 3)

Example 3

Input: @ints = (0, 3, 0, 4, 5)
Ouput: (0, 0, 3, 0, 0)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 24th September
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"slices"
)

func main() {
	for _, data := range []struct {
		input, output []int
	}{
		{[]int{1, 0, 2, 3, 0, 4, 5, 0}, []int{1, 0, 0, 2, 3, 0, 0, 4}},
		{[]int{1, 2, 3}, []int{1, 2, 3}},
		{[]int{0, 3, 0, 4, 5}, []int{0, 0, 3, 0, 0}},
	} {
		fmt.Println(slices.Equal(dupZero(data.input), data.output))
	}
}

func dupZero(s []int) []int {
	l := len(s)
	i := 0
	for i < l {
		if s[i] == 0 {
			copy(s[i+2:], s[i+1:])
			s[i+1] = 0
			i++
		}
		i++
	}
	return s
}
