//# https://theweeklychallenge.org/blog/perl-weekly-challenge-250/
/*#

Task 1: Smallest Index

Submitted by: [38]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the smallest index i such that i mod 10 ==
   $ints[i] otherwise return -1.

Example 1

Input: @ints = (0, 1, 2)
Output: 0

i=0: 0 mod 10 = 0 == $ints[0].
i=1: 1 mod 10 = 1 == $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].
All indices have i mod 10 == $ints[i], so we return the smallest index 0.

Example 2

Input: @ints = (4, 3, 2, 1)
Output: 2

i=0: 0 mod 10 = 0 != $ints[0].
i=1: 1 mod 10 = 1 != $ints[1].
i=2: 2 mod 10 = 2 == $ints[2].
i=3: 3 mod 10 = 3 != $ints[3].
2 is the only index which has i mod 10 == $ints[i].

Example 3

Input: @ints = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
Output: -1
Explanation: No index satisfies i mod 10 == $ints[i].

Task 2: Alphanumeric String Value
#*/
//# solution by pokgopun@gmail.com

package main

import (
	"io"
	"os"

	"github.com/google/go-cmp/cmp"
)

type ints []int

func (is ints) smallestIndex() int {
	for i, v := range is {
		if i%10 == v {
			return i
		}
	}
	return -1
}

func main() {
	for _, data := range []struct {
		input  ints
		output int
	}{
		{ints{0, 1, 2}, 0},
		{ints{4, 3, 2, 1}, 2},
		{ints{1, 2, 3, 4, 5, 6, 7, 8, 9, 0}, -1},
	} {
		io.WriteString(os.Stdout, cmp.Diff(data.input.smallestIndex(), data.output)) // output nothing if ok, otherwise show the difference
	}
}
