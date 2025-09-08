//# https://theweeklychallenge.org/blog/perl-weekly-challenge-338/
/*#

Task 2: Max Distance

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two integer arrays, @arr1 and @arr2.

   Write a script to find the maximum difference between any pair of
   values from both arrays.

Example 1

Input: @arr1 = (4, 5, 7)
       @arr2 = (9, 1, 3, 4)
Output: 6

With element $arr1[0] = 4
| 4 - 9 | = 5
| 4 - 1 | = 3
| 4 - 3 | = 1
| 4 - 4 | = 0
max distance = 5

With element $arr1[1] = 5
| 5 - 9 | = 4
| 5 - 1 | = 4
| 5 - 3 | = 2
| 5 - 4 | = 1
max distance = 4

With element $arr1[2] = 7
| 7 - 9 | = 2
| 7 - 1 | = 6
| 7 - 3 | = 4
| 7 - 4 | = 4
max distance = 6

max (5, 6, 6) = 6

Example 2

Input: @arr1 = (2, 3, 5, 4)
       @arr2 = (3, 2, 5, 5, 8, 7)
Output: 6

With element $arr1[0] = 2
| 2 - 3 | = 1
| 2 - 2 | = 0
| 2 - 5 | = 3
| 2 - 5 | = 3
| 2 - 8 | = 6
| 2 - 7 | = 5
max distance = 6

With element $arr1[1] = 3
| 3 - 3 | = 0
| 3 - 2 | = 1
| 3 - 5 | = 2
| 3 - 5 | = 2
| 3 - 8 | = 5
| 3 - 7 | = 4
max distance = 5

With element $arr1[2] = 5
| 5 - 3 | = 2
| 5 - 2 | = 3
| 5 - 5 | = 0
| 5 - 5 | = 0
| 5 - 8 | = 3
| 5 - 7 | = 2
max distance = 3

With element $arr1[3] = 4
| 4 - 3 | = 1
| 4 - 2 | = 2
| 4 - 5 | = 1
| 4 - 5 | = 1
| 4 - 8 | = 4
| 4 - 7 | = 3
max distance = 4

max (5, 6, 3, 4) = 6

Example 3

Input: @arr1 = (2, 1, 11, 3)
       @arr2 = (2, 5, 10, 2)
Output: 9

With element $arr1[0] = 2
| 2 - 2  | = 0
| 2 - 5  | = 3
| 2 - 10 | = 8
| 2 - 2  | = 0
max distance = 8

With element $arr1[1] = 1
| 1 - 2  | = 1
| 1 - 5  | = 4
| 1 - 10 | = 9
| 1 - 2  | = 1
max distance = 9

With element $arr1[2] = 11
| 11 - 2  | = 9
| 11 - 5  | = 6
| 11 - 10 | = 1
| 11 - 2  | = 9
max distance = 9

With element $arr1[3] = 3
| 3 - 2  | = 1
| 3 - 5  | = 2
| 3 - 10 | = 7
| 3 - 2  | = 1
max distance = 7

max (8, 9, 9, 7) = 9

Example 4

Input: @arr1 = (1, 2, 3)
       @arr2 = (3, 2, 1)
Output: 2

With element $arr1[0] = 1
| 1 - 3 | = 2
| 1 - 2 | = 1
| 1 - 1 | = 0
max distance = 2

With element $arr1[1] = 2
| 2 - 3 | = 1
| 2 - 2 | = 0
| 2 - 1 | = 1
max distance = 1

With element $arr1[2] = 3
| 3 - 3 | = 0
| 3 - 2 | = 1
| 3 - 1 | = 2
max distance = 2

max (2, 1, 2) = 2

Example 5

Input: @arr1 = (1, 0, 2, 3)
       @arr2 = (5, 0)
Output: 5

With element $arr1[0] = 1
| 1 - 5 | = 4
| 1 - 0 | = 1
max distance = 4

With element $arr1[1] = 0
| 0 - 5 | = 5
| 0 - 0 | = 0
max distance = 5

With element $arr1[2] = 2
| 2 - 5 | = 3
| 2 - 0 | = 2
max distance = 3

With element $arr1[3] = 3
| 3 - 5 | = 2
| 3 - 0 | = 3
max distance = 3

max (4, 5, 3, 3) = 5
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 14th September
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (in ints) md(n int) int {
	mx := max(in[0], n) - min(in[0], n)
	for _, v := range in[1:] {
		mx = max(mx, max(v, n)-min(v, n))
	}
	return mx
}

type input struct {
	arr1, arr2 ints
}

func (in input) process() int {
	mx := in.arr2.md(in.arr1[0])
	for _, v := range in.arr1[1:] {
		mx = max(mx, in.arr2.md(v))
	}
	return mx
}

func main() {
	for _, data := range []struct {
		input  input
		output int
	}{
		{input{ints{4, 5, 7}, ints{9, 1, 3, 4}}, 6},
		{input{ints{2, 3, 5, 4}, ints{3, 2, 5, 5, 8, 7}}, 6},
		{input{ints{2, 1, 11, 3}, ints{2, 5, 10, 2}}, 9},
		{input{ints{1, 2, 3}, ints{3, 2, 1}}, 2},
		{input{ints{1, 0, 2, 3}, ints{5, 0}}, 5},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.process(), data.output)) // blank if ok, otherwise show the difference
	}
}
