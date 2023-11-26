//# https://theweeklychallenge.org/blog/perl-weekly-challenge-238/
/*#

Task 1: Running Sum

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return the running sum of the given array. The
   running sum can be calculated as sum[i] = num[0] + num[1] + …. +
   num[i].

Example 1

Input: @int = (1, 2, 3, 4, 5)
Output: (1, 3, 6, 10, 15)

Example 2

Input: @int = (1, 1, 1, 1, 1)
Output: (1, 2, 3, 4, 5)

Example 3

Input: @int = (0, -1, 1, 2)
Output: (0, -1, 0, 2)

Task 2: Persistence Sort
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
		{[]int{1, 2, 3, 4, 5}, []int{1, 3, 6, 10, 15}},
		{[]int{1, 1, 1, 1, 1}, []int{1, 2, 3, 4, 5}},
		{[]int{0, -1, 1, 2}, []int{0, -1, 0, 2}},
	} {
		fmt.Println(slices.Equal(runningSum(data.input), data.output))
	}
}

func runningSum(s []int) []int {
	l := len(s)
	for i := 1; i < l; i++ {
		s[i] += s[i-1]
	}
	return s
}
