//# https://theweeklychallenge.org/blog/perl-weekly-challenge-235/
/*#

Task 1: Remove One

Submitted by: [44]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to find out if removing ONLY one integer makes it
   strictly increasing order.

Example 1

Input: @ints = (0, 2, 9, 4, 6)
Output: true

Removing ONLY 9 in the given array makes it strictly increasing order.

Example 2

Input: @ints = (5, 1, 3, 2)
Output: false

Example 3

Input: @ints = (2, 2, 3)
Output: true

Task 2: Duplicate Zeros
#*/
//# solution by pokgopun@gmail.com

package main

import "fmt"

func main() {
	for _, data := range []struct {
		input  []int
		output bool
	}{
		{[]int{0, 2, 9, 4, 6}, true},
		{[]int{5, 1, 3, 2}, false},
		{[]int{2, 2, 3}, true},
	} {
		fmt.Println(isRmoSorted(data.input) == data.output)
	}
}

func isRmoSorted(s []int) bool {
	l := len(s)
	var (
		first, isSorted bool
		v               int
	)
	for i := 0; i < l; i++ {
		isSorted = true
		first = true
		for j := 0; j < l; j++ {
			if j == i {
				continue
			}
			if first == true {
				first = false
			} else {
				if s[v] > s[j] {
					isSorted = false
					break
				}
			}
			v = j
		}
		if isSorted == true {
			return true
		}
	}
	return false
}
