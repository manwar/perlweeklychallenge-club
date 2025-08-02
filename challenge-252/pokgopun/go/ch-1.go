//# https://theweeklychallenge.org/blog/perl-weekly-challenge-252/
/*#

Task 1: Special Numbers

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the sum of the squares of all special elements
   of the given array.
An element $int[i] of @ints is called special if i divides n, i.e. n % i == 0.
Where n is the length of the given array. Also the array is 1-indexed for the ta
sk.

Example 1

Input: @ints = (1, 2, 3, 4)
Output: 21

There are exactly 3 special elements in the given array:
$ints[1] since 1 divides 4,
$ints[2] since 2 divides 4, and
$ints[4] since 4 divides 4.

Hence, the sum of the squares of all special elements of given array:
1 * 1 + 2 * 2 + 4 * 4 = 21.

Example 2

Input: @ints = (2, 7, 1, 19, 18, 3)
Output: 63

There are exactly 4 special elements in the given array:
$ints[1] since 1 divides 6,
$ints[2] since 2 divides 6,
$ints[3] since 3 divides 6, and
$ints[6] since 6 divides 6.

Hence, the sum of the squares of all special elements of given array:
2 * 2 + 7 * 7 + 1 * 1 + 3 * 3 = 63

Task 2: Unique Sum Zero
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) snum() int {
	l := len(is)
	r := 0
	for i, v := range is {
		if l%(i+1) == 0 {
			r += v * v
		}
	}
	return r
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{1, 2, 3, 4}, 21},
		{ints{2, 7, 1, 19, 18, 3}, 63},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.snum(), data.output)) // blank if ok, otherwise show the difference
	}
}
