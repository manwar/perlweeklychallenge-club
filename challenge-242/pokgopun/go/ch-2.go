//# https://theweeklychallenge.org/blog/perl-weekly-challenge-242/
/*#

Task 2: Flip Matrix

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given n x n binary matrix.

   Write a script to flip the given matrix as below.
1 1 0
0 1 1
0 0 1

a) Reverse each row

0 1 1
1 1 0
1 0 0

b) Invert each member

1 0 0
0 0 1
0 1 1

Example 1

Input: @matrix = ([1, 1, 0], [1, 0, 1], [0, 0, 0])
Output: ([1, 0, 0], [0, 1, 0], [1, 1, 1])

Example 2

Input: @matrix = ([1, 1, 0, 0], [1, 0, 0, 1], [0, 1, 1, 1], [1, 0, 1, 0])
Output: ([1, 1, 0, 0], [0, 1, 1, 0], [0, 0, 0, 1], [1, 0, 1, 0])
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 12th November
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"fmt"
	"reflect"
	"slices"
)

type row []int

func (r row) invert() row {
	for i := range r {
		r[i] ^= 1
	}
	return r
}

func (r row) reverse() row {
	slices.Reverse(r)
	return r
}

type matrix []row

func (m matrix) flip() matrix {
	for _, v := range m {
		v.invert().reverse()
	}
	return m
}

func main() {
	for _, data := range []struct {
		input, output matrix
	}{
		{matrix{row{1, 1, 0}, row{1, 0, 1}, row{0, 0, 0}}, matrix{row{1, 0, 0}, row{0, 1, 0}, row{1, 1, 1}}},
		{matrix{row{1, 1, 0, 0}, row{1, 0, 0, 1}, row{0, 1, 1, 1}, row{1, 0, 1, 0}}, matrix{row{1, 1, 0, 0}, row{0, 1, 1, 0}, row{0, 0, 0, 1}, row{1, 0, 1, 0}}},
	} {
		//fmt.Println(data.input, data.output)
		fmt.Println(reflect.DeepEqual(data.input.flip(), data.output))
	}
}
