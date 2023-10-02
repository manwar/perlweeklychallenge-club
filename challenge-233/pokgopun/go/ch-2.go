// https://theweeklychallenge.org/blog/perl-weekly-challenge-233/
/*
Task 2: Frequency Sort

Submitted by: [44]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to sort the given array in increasing order based on the
   frequency of the values. If multiple values have the same frequency
   then sort them in decreasing order.

Example 1

Input: @ints = (1,1,2,2,2,3)
Ouput: (3,1,1,2,2,2)

'3' has a frequency of 1
'1' has a frequency of 2
'2' has a frequency of 3

Example 2

Input: @ints = (2,3,1,3,2)
Ouput: (1,3,3,2,2)

'2' and '3' both have a frequency of 2, so they are sorted in decreasing order.

Example 3

Input: @ints = (-1,1,-6,4,5,-6,1,4,1)
Ouput: (5,-1,4,4,-6,-6,1,1,1)
*/
package main

import (
	"fmt"
	"slices"
)

func main() {
	for _, data := range []struct {
		input  []int
		output []int
	}{
		{[]int{1, 1, 2, 2, 2, 3}, []int{3, 1, 1, 2, 2, 2}},
		{[]int{2, 3, 1, 3, 2}, []int{1, 3, 3, 2, 2}},
		{[]int{-1, 1, -6, 4, 5, -6, 1, 4, 1}, []int{5, -1, 4, 4, -6, -6, 1, 1, 1}},
	} {
		//fmt.Println("=>", mSort(data.input), data.output)
		fmt.Println(slices.Compare(mSort(data.input), data.output) == 0)
	}
}

func mSort(s []int) (r []int) {
	num2frq := map[int]int{}
	for _, v := range s {
		num2frq[v]++
	}
	frq2nums := map[int][]int{}
	for n, f := range num2frq {
		frq2nums[f] = append(frq2nums[f], n)
	}
	//fmt.Println(frq2nums)
	frqs := []int{}
	for f := range frq2nums {
		frqs = append(frqs, f)
		slices.Sort(frq2nums[f])
		slices.Reverse(frq2nums[f])
	}
	slices.Sort(frqs)
	//fmt.Println(frqs, frq2nums)
	for _, f := range frqs {
		for _, n := range frq2nums[f] {
			for i := 0; i < f; i++ {
				r = append(r, n)
			}
		}
	}
	return r
}
