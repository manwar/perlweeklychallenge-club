// https://theweeklychallenge.org/blog/perl-weekly-challenge-230/
/*
Task 1: Separate Digits
Submitted by: Mohammad S Anwar
You are given an array of positive integers.

Write a script to separate the given array into single digits.

Example 1
Input: @ints = (1, 34, 5, 6)
Output: (1, 3, 4, 5, 6)
Example 2
Input: @ints = (1, 24, 51, 60)
Output: (1, 2, 4, 5, 1, 6, 0)

*/
package main

import (
	"fmt"
	"reflect"
)

func main() {
	for _, data := range []struct {
		input  []int
		output []int
	}{
		{
			[]int{1, 34, 5, 6},
			[]int{1, 3, 4, 5, 6},
		},
		{
			[]int{1, 24, 51, 60},
			[]int{1, 2, 4, 5, 1, 6, 0},
		},
	} {
		fmt.Println(reflect.DeepEqual(IntSliceToDigitSlice(data.input), data.output))
	}
	/* Testing IntToDigitSlice
	for _, data := range []struct {
		input  int
		output []int
		res    bool
	}{
		{123, []int{1, 2, 3}, true},
		{504, []int{5, 0, 4}, true},
		{0, []int{0}, true},
		{303, []int{3, 3}, false},
		{10, []int{1}, false},
		{100, []int{1, 0}, false},
	} {
		fmt.Println(reflect.DeepEqual(IntToDigitSlice(data.input), data.output) == data.res)
	}
	*/
}
func IntToDigitSlice(i int) (s []int) {
	for i > 10 {
		s = append([]int{i % 10}, s...)
		i = i / 10
	}
	s = append([]int{i}, s...)
	return s
}

func IntSliceToDigitSlice(is []int) (ds []int) {
	for _, v := range is {
		ds = append(ds, IntToDigitSlice(v)...)
	}
	return ds
}
