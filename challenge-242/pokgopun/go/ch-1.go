//# https://theweeklychallenge.org/blog/perl-weekly-challenge-242/
/*#

Task 1: Missing Members

Submitted by: [42]Mohammad S Anwar
     __________________________________________________________________

   You are given two arrays of integers.

   Write a script to find out the missing members in each other arrays.

Example 1

Input: @arr1 = (1, 2, 3)
       @arr2 = (2, 4, 6)
Output: ([1, 3], [4, 6])

(1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
(2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).

Example 2

Input: @arr1 = (1, 2, 3, 3)
       @arr2 = (1, 1, 2, 2)
Output: ([3])

(1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they
are same, keep just one.
(1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).

Task 2: Flip Matrix
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"reflect"
	"slices"
)

type arr []int

type arrp struct {
	arr1, arr2 arr
}

func (ap arrp) missing() (sa []arr) {
	ap.arr1 = slices.Compact(ap.arr1)
	ap.arr2 = slices.Compact(ap.arr2)
	aa := [2]arr{ap.arr1, ap.arr2}
	for i, v := range aa {
		arr0 := make(arr, len(v))
		copy(arr0, v)
		arr0 = slices.DeleteFunc(arr0, func(n int) bool {
			return slices.Contains(aa[i^1], n)
		})
		if len(arr0) > 0 {
			sa = append(sa, arr0)
		}
	}
	return sa
}
func main() {
	for _, data := range []struct {
		input  arrp
		output []arr
	}{
		{arrp{arr{1, 2, 3}, arr{2, 4, 6}}, []arr{arr{1, 3}, arr{4, 6}}},
		{arrp{arr{1, 2, 3, 3}, arr{1, 1, 2, 2}}, []arr{arr{3}}},
	} {
		fmt.Println(reflect.DeepEqual(data.input.missing(), data.output))
	}
}
