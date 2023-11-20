//# https://theweeklychallenge.org/blog/perl-weekly-challenge-243/
/*#

Task 1: Reverse Pairs

Submitted by: [50]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return the number of reverse pairs in the given
   array.

   A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and
   b) nums[i] > 2 * nums[j].

Example 1

Input: @nums = (1, 3, 2, 3, 1)
Output: 2

(1, 4) => nums[1] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 3, nums[4] = 1, 3 > 2 * 1

Example 2

Input: @nums = (2, 4, 3, 5, 1)
Output: 3

(1, 4) => nums[1] = 4, nums[4] = 1, 4 > 2 * 1
(2, 4) => nums[2] = 3, nums[4] = 1, 3 > 2 * 1
(3, 4) => nums[3] = 5, nums[4] = 1, 5 > 2 * 1

Task 2: Floor Sum
#*/
//# solution by pokgopun@gmail.com

package main

import "fmt"

type nums []int

func (n nums) rpCount() int {
	c, l := 0, len(n)
	for i := 0; i < l-1; i++ {
		for j := i + 1; j < l; j++ {
			if n[i] > 2*n[j] {
				c++
			}
		}
	}
	return c
}

func main() {
	for _, data := range []struct {
		input  nums
		output int
	}{
		{nums{1, 3, 2, 3, 1}, 2},
		{nums{2, 4, 3, 5, 1}, 3},
	} {
		fmt.Println(data.input.rpCount() == data.output)
	}
}
