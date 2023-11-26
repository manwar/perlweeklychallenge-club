//# https://theweeklychallenge.org/blog/perl-weekly-challenge-237/
/*#

Task 2: Maximise Greatness

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to permute the give array such that you get the maximum
   possible greatness.

     To determine greatness, nums[i] < perm[i] where 0 <= i < nums.length

Example 1

Input: @nums = (1, 3, 5, 2, 1, 3, 1)
Output: 4

One possible permutation: (2, 5, 1, 3, 3, 1, 1) which returns 4 greatness as bel
ow:
nums[0] < perm[0]
nums[1] < perm[1]
nums[3] < perm[3]
nums[4] < perm[4]

Example 2

Input: @ints = (1, 2, 3, 4)
Output: 3

One possible permutation: (2, 3, 4, 1) which returns 3 greatness as below:
nums[0] < perm[0]
nums[1] < perm[1]
nums[2] < perm[2]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 8th October
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import "fmt"

func main() {
	for _, data := range []struct {
		input  []int
		output uint
	}{
		{[]int{1, 3, 5, 2, 1, 3, 1}, 4},
		{[]int{1, 2, 3, 4}, 3},
	} {
		fmt.Println(mySlice(data.input).maxGreat() == data.output)
	}
}

type mySlice []int

func (ms mySlice) maxGreat() uint {
	n := uint(len(ms))
	fact := uint(1)
	for i := n; i > 1; i-- {
		fact *= i
	}
	var g, mg uint
	for r := uint(0); r < fact; r++ {
		g = ms.great(n, r, fact)
		if mg < g {
			mg = g
		}
	}
	return mg
}

func (ms mySlice) great(n, r, fact uint) (g uint) {
	if r > fact-1 {
		return 0
	}
	fact /= n
	digits := make([]uint, uint(n))
	for i := uint(0); i < n; i++ {
		digits[i] = i
	}
	var q uint
	for i := uint(0); i < n; i++ {
		q = r / fact
		r %= fact
		if ms[digits[q]] > ms[i] {
			g++
		}
		copy(digits[q:], digits[q+1:])
		if i != n-1 {
			fact /= n - 1 - i
		}
	}
	return g
}
