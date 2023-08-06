// https://theweeklychallenge.org/blog/perl-weekly-challenge-228/
/*
Task 1: Unique Sum
Submitted by: Mohammad S Anwar
You are given an array of integers.

Write a script to find out the sum of unique elements in the given array.

Example 1
Input: @int = (2, 1, 3, 2)
Output: 4

In the given array we have 2 unique elements (1, 3).
Example 2
Input: @int = (1, 1, 1, 1)
Output: 0

In the given array no unique element found.
Example 3
Input: @int = (2, 1, 3, 4)
Output: 10

In the given array every element is unique.
*/

package main

import "fmt"

func main() {
	var su SumUniq
	for _, data := range []struct {
		input  []int
		output int
	}{
		{[]int{2, 1, 3, 2}, 4},
		{[]int{1, 1, 1, 1}, 0},
		{[]int{2, 1, 3, 4}, 10},
	} {
		fmt.Println(su.Cal(data.input) == data.output)
	}
}

type SumUniq struct {
	m    map[int]int
	k, v int
	val  int
}

func (su SumUniq) Cal(s []int) int {
	su.m = make(map[int]int, len(s))
	for _, su.v = range s {
		su.m[su.v]++
	}
	for su.k, su.v = range su.m {
		if su.v == 1 {
			su.val += su.k
		}
	}
	return su.val
}
