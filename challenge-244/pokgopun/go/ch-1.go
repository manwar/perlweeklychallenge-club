//# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/
/*#

Task 1: Count Smaller

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to calculate the number of integers smaller than the
   integer at each index.

Example 1

Input: @int = (8, 1, 2, 2, 3)
Output: (4, 0, 1, 1, 3)

For index = 0, count of elements less 8 is 4.
For index = 1, count of elements less 1 is 0.
For index = 2, count of elements less 2 is 1.
For index = 3, count of elements less 2 is 1.
For index = 4, count of elements less 3 is 3.

Example 2

Input: @int = (6, 5, 4, 8)
Output: (2, 1, 0, 3)

Example 3

Input: @int = (2, 2, 2)
Output: (0, 0, 0)

Task 2: Group Hero
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"reflect"
)

type mArr []int

func (ma mArr) conv() (r mArr) {
	l := len(ma)
	r = make(mArr, l)
	for i, v := range ma {
		for j := 0; j < l; j++ {
			if ma[j] < v {
				r[i]++
			}
		}
	}
	return r
}

func main() {
	for _, data := range []struct {
		input, output mArr
	}{
		{mArr{8, 1, 2, 2, 3}, mArr{4, 0, 1, 1, 3}},
		{mArr{6, 5, 4, 8}, mArr{2, 1, 0, 3}},
		{mArr{2, 2, 2}, mArr{0, 0, 0}},
	} {
		fmt.Println(reflect.DeepEqual(data.input.conv(), data.output))
	}
}
